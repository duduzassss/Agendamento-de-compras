from flask import Flask, request, render_template, redirect, flash, url_for, current_app, abort, jsonify
#from forms import LoginForm, RegistrationForm
from flask_login import LoginManager, login_user, logout_user, login_required, current_user, AnonymousUserMixin
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from datetime import datetime, timedelta,date

from flask_wtf import FlaskForm
from wtforms import StringField, BooleanField,PasswordField,SubmitField, IntegerField, DateField, FloatField
from wtforms.fields.html5 import EmailField
from wtforms.validators import DataRequired , Length, EqualTo, Email
from flask_bootstrap import Bootstrap
from flask_security import Security, SQLAlchemyUserDatastore, \
    UserMixin, RoleMixin, login_required
from functools import wraps
from werkzeug.security import generate_password_hash, check_password_hash
from flask_migrate import Migrate

from string import Template # importação do join do favoritar que o professor me mandou

app = Flask(__name__)
app.config['SECRET_KEY'] = 'any vcbvbcbsecrejgdhkjghdkjh78687jgh6j7ghjghjmt string'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///clientes.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['CSRF_ENABLED'] = True 
app.config['USER_ENABLE_EMAIL'] = False
# Set config values for Flask-Security.
# We're using PBKDF2 with salt.
app.config['SECURITY_PASSWORD_HASH'] = 'pbkdf2_sha512'
# Replace this with your own salt.
app.config['SECURITY_PASSWORD_SALT'] = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
app.config['FLASKY_ADMIN'] = 'eduardo.pbitencourt@hotmail.com'


bootstrap = Bootstrap(app)
db = SQLAlchemy(app)
lm = LoginManager(app)
migrate = Migrate(app, db)


class Permission:
    FAVORITE = 1
    COMMENT = 2
    PURCHASE = 4
    MODERATE = 8
    ADMIN = 16

# Role class
class Role(db.Model, RoleMixin):
    # Our Role has three fields, ID, name and description
    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.String(80), unique=True)
    default = db.Column(db.Boolean, default= False, index=True)
    permissions = db.Column(db.Integer)
    users = db.relationship('Usuario', backref='role', lazy='dynamic')

    def __init__(self, **kwargs):
        super(Role, self).__init__(**kwargs)
        if self.permissions is None:
            self.permissions = 0

    @staticmethod
    def insert_roles():
        roles = {
            'User': [Permission.FAVORITE, Permission.COMMENT, Permission.PURCHASE],
            'Moderator': [Permission.FAVORITE, Permission.COMMENT,
                            Permission.PURCHASE, Permission.MODERATE],
            'Administrator': [Permission.FAVORITE, Permission.COMMENT, Permission.PURCHASE,
                            Permission.MODERATE, Permission.ADMIN],
        }
        default_role = 'User'
        for r in roles:
            role = Role.query.filter_by(name = r).first()
            if role is None:
                role = Role(name = r)
            role.reset_permission()
            for perm in roles[r]:
                role.add_permission(perm)
            role.default = (role.name == default_role)
            db.session.add(role)
        db.session.commit()


    def add_permission(self, perm):
        if not self.has_permission(perm):
            self.permissions += perm

    def remove_permission(self, perm):
        if self.has_permission(perm):
            self.permissions -= perm

    def reset_permission(self):
        self.permissions = 0

    def has_permission(self, perm):
        return self.permissions & perm == perm

    def __repr__(self):
        return '<Role %r>' % self.name

####################################
PERIODO_COMPRA=  timedelta(days=30)#FAVORITOS (TIRAR CASO DE ERRADO)
"""
favoritos = db.Table('favoritos',
            db.Column('id',db.Integer, primary_key=True),
            db.Column('usuarios_id',db.Integer, db.ForeignKey('usuarios.id')),
            db.Column('produtos_id',db.Integer, db.ForeignKey('produtos.id')),
            db.Column('data_compra',db.DateTime(),default=datetime.now),
            db.Column('data_renova_compra',db.DateTime(),default=datetime.now()+PERIODO_COMPRA)
            )#FAVORITOS (TIRAR CASO DE ERRADO)
"""
####################################

class Usuario(db.Model, UserMixin):
    __tablename__ = "usuarios"
    id = db.Column(db.Integer , primary_key=True)
    username = db.Column('username', db.String(20), unique=True , index=True)
    password_hash = db.Column('password' , db.String(10))
    email = db.Column('email',db.String(50),unique=True , index=True)
    registered_on = db.Column('registered_on' , db.DateTime)
    active = db.Column(db.Boolean())
    role_id = db.Column(db.Integer, db.ForeignKey('role.id'))
    telefone = db.Column('telefone', db.String(11))
    endereco = db.Column('endereco', db.String(100))
    cartao = db.Column('cartao', db.String(16))
    cpf = db.Column('cpf', db.String(11))
    nascimento = db.Column('data_nasc', db.DateTime())
    #usuario = db.relationship('Produtos', secondary=favoritos, backref=db.backref('pedido', lazy='dynamic'))#FAVORITOS (TIRAR CASO DE ERRADO)
#aqui
    @property
    def password(self):
        raise AttributeError('password is not a readable attribute')

    @password.setter
    def password(self, password):
        self.password_hash = generate_password_hash(password)

    def verify_password(self, password):
        return check_password_hash(self.password_hash, password)

    def __repr__(self):
        return '<user %r>' % self.username

    def __init__(self, **kwargs):
        super(Usuario,self).__init__(**kwargs)
        if self.role is None:
            if self.email == current_app.config['FLASKY_ADMIN']:
                self.role = Role.query.filter_by(name='Administrator').first()
            if self.role is None:
                self.role = Role.query.filter_by(default=True).first()

    def can (self, perm):
        return self.role is not None and self.role.has_permission(perm)

    def is_administrator(self):
        return self.can(Permission.ADMIN)



class AnonymousUser(AnonymousUserMixin):
    def can(self, permissions):
        return False

    def is_administrator(self):
        return False

lm.anonymous_user = AnonymousUser

"""
    @property
    def password(self):
        raise AttributeError('password is not a readable attribute')

    @password.setter
    def password(self, password):
        self.password_hash = generate_password_hash(password)

    def verify_password(self, password):
        return check_password_hash(self.password_hash, password)

    def __repr__(self):
        return '<user %r>' % self.username
"""



class ProdutoForm(FlaskForm):
    nome_produto = StringField('Nome do produto', validators=[Length(max=150)])
    valor = FloatField('Valor', validators=[])
    botao = SubmitField('Cadastrar Produto')


class PedidosForm(FlaskForm):
    numero = IntegerField('Numero do pedido', validators=[])
    total = FloatField('Total', validators=[])
    data = DateField('Data', format='%d/%m/%Y', validators=[])
    pago = BooleanField('Pago', validators=[])
    liberado_entrega = BooleanField('Liberado para entrega?', validators=[])
    entregue = BooleanField('Entregue?', validators=[])
    data_agendamento = DateField('Data Agendamento',format='%d/%m/%Y',validators=[])
    botao = SubmitField('Fazer Pedido')

class AtualizaPedidosForm(FlaskForm):
    pago = BooleanField('Pago', validators=[])
    liberado_entrega = BooleanField('Liberado para entrega', validators=[])
    entregue = BooleanField('Entregue', validators=[])
    botao = SubmitField('Atualizar Pedido')

class UserForm(FlaskForm):
    username = StringField('Nome de usuario', validators=[Length(max=70)])
    password = PasswordField('Senha', validators=[Length(min=1, max=200)])
    email = EmailField('Email', validators=[Length(max=100)])
    botao = SubmitField('Enviar')

"""
    def __init__(self, **kwargs):
        super(Usuario,self).__init__(**kwargs)
        if self.role is None:
            if self.email == current_app.config['FLASKY_ADMIN']:
                self.role = Role.query.filter_by(name='Administrator').first()
            if self.role is None:
                self.role = Role.query.filter_by(default=True).first()
"""
# Usado na parte de editar informações do perfil do usuario. (/usuario/edit/id)
class UserProfileForm(FlaskForm):
    telefone = StringField('Telefone', validators=[Length(min=11, max=11)])
    endereco = StringField('Endereço', validators=[Length(max=100)])
    cpf = StringField('CPF', validators=[Length(min=11, max=11)])
    cartao = StringField('Cartão', validators=[Length(min=16, max=16)])
    nascimento = DateField('Data de nascimento', format='%d/%m/%Y',validators=[])
    botao = SubmitField('Enviar')

    @property
    def is_authenticated(self):
        return True

    @property
    def is_active(self):
        return True

    @property
    def is_anonymous(self):
        return False

    def get_id(self):
        return str(self.id)
"""
    def can (self, perm):
        return self.role is not None and self.role.has_permission(perm)

    def is_administrator(self):
        return self.can(Permission.ADMIN)



class AnonymousUser(AnonymousUserMixin):
    def can(self, permissions):
        return False

    def is_administrator(self):
        return False
"""

#criando decorador personalizado para verificar permissions
def permission_required(permission):
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            if not current_user.can(permission):
                abort(403)
            return f(*args, **kwargs)
        return decorated_function
    return decorator

def admin_required(f):
    return permission_required(Permission.ADMIN)(f)


class Produtos(db.Model):
    __tablename__="produtos"
    id = db.Column(db.Integer, primary_key=True)
    nome_produto = db.Column('nome_produto', db.String(50), unique=True)
    valor = db.Column('valor', db.Integer)
    favoritar = db.Column('favoritar', db.Boolean, default=False)
    

class Favoritos(db.Model):
    __tablename__ = "favoritos"
    id = db.Column(db.Integer, primary_key=True)
    usuarios_id= db.Column('usuarios_id',db.Integer, db.ForeignKey('usuarios.id'))
    produtos_id= db.Column('produtos_id',db.Integer, db.ForeignKey('produtos.id'))

    

    def __repr__(self):
        return 'Favorito {}'.format(self.produtos_id)
    #periodicidade= db.Column(db.)
    #pedir ajuda pro professor nessa parte de favoritos

class Pedidos(db.Model):
    __tablename__    = "pedidos"
    id               = db.Column(db.Integer, primary_key=True)
    user_id          = db.Column('usuarios_id', db.Integer, db.ForeignKey('usuarios.id'))
    data             = db.Column('data', db.Date,default=datetime.now())
    total            = db.Column('total', db.Integer)
    pago             = db.Column('pago', db.Boolean, default=False)
    liberado_entrega = db.Column('liberado_entrega', db.Boolean, default=False)
    entregue         = db.Column('entregue', db.Boolean, default=False)
    dinheiro         = db.Column('dinheiro', db.Float, default=0)
    troco            = db.Column('troco', db.Float, default=0)
    data_agendamento = db.Column('data_agendamento',db.Integer)
    ped_itens        = db.relationship('Itens')


    def renovar(self):
        return date.today().day == self.data_agendamento
                

    def data_renovacao(self):
    	if self.data.month == 12:
    		return '{}/{}'.format(self.data_agendamento, 1)
    	else:
    		return '{}/{}'.format(self.data_agendamento, self.data.month+1)


class Itens(db.Model):
    __tablename__ = "itens"
    id = db.Column(db.Integer, primary_key=True)
    produtos_id = db.Column(db.Integer, db.ForeignKey('produtos.id'))
    pedidos_id = db.Column(db.Integer, db.ForeignKey('pedidos.id'))
    quant = db.Column('quantidade', db.Integer)
    valor = db.Column('valor_total', db.Float)

    def __repr__(self):
        return 'item{} {}'.format(self.produtos_id, self.pedidos_id)
login_manager = LoginManager()
login_manager.setup_app(app)
login_manager.login_view = 'login'


@login_manager.user_loader
def load_user(userid):
    return Usuario.query.get(userid)

#######PAGINA INICIAL##########
@app.route('/')
def index():
    user = ''
    return render_template('index.tpl',user=user)
    
    
#####################LOGIN AND REGISTER###################

class PerfilForm(FlaskForm):
    telefone = StringField('Telefone', validators= [Length(min=11, max=11)])
    endereco = StringField('Endereço', validators= [Length(min=8, max=50)])
    cartao = StringField('Cartão', validators = [Length(min=16, max=16)])
    cpf = StringField('CPF', validators = [Length(min= 11, max=11)])
    nascimento = DateField('Data de nascimento', format='%d/%m/%Y',validators = [])
    botao = SubmitField("Enviar")

class RegisterForm(FlaskForm):
    username = StringField('Username', validators= [Length(min=4, max=25)])
    email = EmailField('Email Address', validators= [Length(min=6, max=35), Email()])
    password = PasswordField('New Password', validators= [
        DataRequired(),
        EqualTo('confirm', message='P/indexasswords must match')
    ])
    confirm = PasswordField('Repeat Password')
    submit = SubmitField('Registrar-se')
   

@app.route("/register", methods=["GET","POST"])
def register():
    form = RegisterForm(request.form)
    if request.method == 'POST' and form.validate():
        user = Usuario(username= form.username.data,role_id=1,email= form.email.data,password= form.password.data,registered_on= datetime.utcnow(),active=1)
        db.session.add(user)
        db.session.commit()
        flash('Obrigado por se registrar. Faça seu login e entre no menu (perfil) para adicionar mais informações sobre voce.','success')
        return redirect(url_for('login'))
    return render_template('register.tpl', form=form)


class LoginForm (FlaskForm):
    email = EmailField("Email", validators=[DataRequired()])
    password = PasswordField("Password",validators=[DataRequired()])
    #remember_me = BooleanField("Lembrar-me")
    botao_entrar = SubmitField("Entrar")


@app.route("/login", methods=["GET","POST"])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = Usuario.query.filter_by(email=form.email.data).first()
        print (user)
        if user:
            if user.verify_password(form.password.data):
                login_user(user)
                flash("Você foi conectado!", 'success')
                flash("Caso seje seu primeiro acesso, vá para aba Perfil e complete suas informações", 'success')
                return redirect('/')
            else:
                flash("Email ou Senha incorretos",'danger')
        else:
            flash("Email ou Senha incorretos",'danger')
    else:
        print (form.errors)
    return render_template('login.html',form=form)


@app.route('/logout', methods=['GET'])
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))

######################################################
    
    
#####################CRUD USUARIO NA WEB###############

@app.route('/perfil/<int:_id_>', methods=['GET'])
@login_required
def WebPerfil_get(_id_):
    dados = Usuario.query.filter_by(id=_id_).first()
    form = PerfilForm(obj=dados)
    return render_template("perfilform.tpl", form=form, id=dados.id)

@app.route('/perfil/<int:_id_>', methods=['POST'])
@login_required
def WebPerfil_post(_id_):
    form = PerfilForm(request.form)
    print (form.cpf.data)
    if form.validate_on_submit():
        try:
            user = Usuario.query.filter_by(id=_id_).first()
            user.telefone= form.telefone.data
            user.endereco= form.endereco.data
            user.cartao= form.cartao.data 
            user.cpf= form.cpf.data
            user.nascimento= form.nascimento.data
            db.session.commit()
            flash('Informações do perfil editadas com sucesso!', 'success')
            print('sucesso')
        except Exception as e:
            flash ('erro'+str(e),'danger')
            print('erro'+str(e))
    else:
        print('invalido', form.errors)
    return redirect('/usuario')


@app.route('/usuario')
@login_required
def WebUser():
    papel = Role.query.filter_by(name='Administrator').first()
    if current_user.role_id == papel.id:
        dados=Usuario.query.all()
    else:
        dados= [Usuario.query.filter_by(id=current_user.id).first()]
    return render_template('usuario.tpl', dados=dados)


@app.route('/usuario/ins', methods=['GET'])
@login_required
def ins_get_usuario():
    form = UserProfileForm()
    return render_template("insert.tpl" , form=form)
 

@app.route('/usuario/ins', methods=['POST'])
@login_required
def ins_post_usuario():
    form = UserProfileForm(request.form)
    print (form.telefone.data)
    if form.validate_on_submit():
        try:
            user = Usuario(telefone= form.telefone.data,endereco= form.endereco.data, cartao= form.cartao.data, 
            cpf= form.cpf.data, nascimento= form.nascimento.data)
            db.session.add(user)
            db.session.commit()
            flash('Cadastrado', 'success')
            print('sucesso')
        except Exception as e:
            flash ('erro'+e ,'danger')
            print('erro'+e)
    else:
        print('invalido', form.errors)
    return redirect('/usuario')

@app.route('/usuario/edit/<int:_id_>', methods=['GET'])
@login_required
def edit_get_usuario(_id_):
    dados = Usuario.query.filter_by(id=_id_).first()
    form = PerfilForm()
    return render_template('edit.tpl', dado=dados, form=form)

@app.route('/usuario/edit/<int:_id_>', methods=['POST'])
@login_required
def edit_post_usuario(_id_):
    user = Usuario.query.filter_by(id=_id_).first()
    form = UserProfileForm(obj=user)     #userprofileform()
    print (form.cpf.data)
    if form.validate_on_submit():
        try:
        
            user.telefone= form.telefone.data
            user.endereco= form.endereco.data
            user.cartao= form.cartao.data 
            user.cpf= form.cpf.data
            user.nascimento= form.nascimento.data
            db.session.add(user)
            db.session.commit()
            flash('Editado com sucesso', 'success')
            print('sucesso')
        except Exception as e:
            flash ('erro'+e ,'danger')
            print('erro'+e)
    else:
        print('invalido', form.errors)
    return redirect('/usuario')


@app.route('/usuario/view/<int:_id_>', methods=['GET'])
#@admin_required
def view_get_usuario(_id_):
    dados = Usuario.query.filter_by(id=_id_).first()

    return render_template('view.tpl', dados=dados)



@app.route('/usuario/del/<int:_id_>', methods=['GET'])
#@admin_required
def del_get_usuario(_id_):
    dados = Usuario.query.filter_by(id=_id_).first()

    return render_template('delete.tpl', dados=dados)


@app.route('/usuario/del/<int:_id_>', methods=['POST'])
#@admin_required
def del_post_usuario(_id_):
    user = Usuario.query.filter_by(id=_id_).first()
    db.session.delete(user)
    db.session.commit()
    return redirect('/usuario')


##########################################################################


####################Construtores_produtos abaixo##############################
@app.route('/produtos')
#@admin_required
def produtos():
    dados = Produtos.query.all()

    return render_template('produtos.tpl', dados=dados)
    
@app.route('/produtos/ins', methods=['GET'])
@admin_required
@login_required
def ins_get_produtos():
    form = ProdutoForm()
    return render_template('insert_produto.tpl', form=form)
    
@app.route('/produtos/ins', methods=['POST'])
@admin_required
@login_required
def ins_post_produtos():
    form = ProdutoForm(request.form)
    print (form.nome_produto.data)
    if form.validate_on_submit():
        try:
            prod = Produtos(nome_produto=form.nome_produto.data, valor= form.valor.data,
                #quantidade= form.quantidade.data
                )
            db.session.add(prod)
            db.session.commit()
            flash('Produto Cadastrado', 'success')
            print('sucesso')
        except Exception as e:
            flash('erro'+str(e),'danger')
            print ('erro'+str(e))
    else:
        print('invalido', form.errors)
    return redirect('/produtos')
    
@app.route('/produtos/edit/<int:_id_>', methods=['GET'])
#@admin_required
@login_required
def edit_get_produtos(_id_):
    dados = Produtos.query.filter_by(id=_id_).first()
    form = ProdutoForm()
    return render_template('edit_produto.tpl', dado=dados, form=form)

@app.route('/produtos/edit/<int:_id_>', methods=['POST'])
#@admin_required
@login_required
def edit_post_produtos(_id_):
    prod = Produtos.query.filter_by(id=_id_).first()
    form = ProdutoForm(obj=prod)     
    print (form.nome_produto.data)
    if form.validate_on_submit():
        try:
            prod.nome_produto= form.nome_produto.data
            prod.valor= form.valor.data
            db.session.add(prod)
            db.session.commit()
            flash('Alterado o valor do produto!', 'success')
            print('sucesso')
        except Exception as e:
            flash ('erro'+e,'danger')
            print('erro'+e)
    else:
        print('invalido', form.errors)
    return redirect('/produtos')

@app.route('/produtos/del/<int:_id_>', methods=['GET'])
@admin_required
@login_required
def del_get_produtos(_id_):
    dados = Produtos.query.filter_by(id=_id_).first()
    return render_template('delete_produto.tpl', dados=dados)


@app.route('/produtos/del/<int:_id_>', methods=['POST'])
@admin_required
@login_required
def del_post_produtos(_id_):
	## VOltar para :
	## prod = Produtos.query.filter_by(id=_id_).first()
	## db.session.delete(prod)
	## db.session.commit()
	## return redirect('/produtos')
	## Caso de erro
	produto_item = Itens.query.filter_by(produtos_id=_id_).first()
	if produto_item:
		flash('Não é possivel deletar este produto, pois tem um pedido com o mesmo.', 'danger')
	else:
		flash('Produto deletado com sucesso!','success')
		prod = Produtos.query.filter_by(id=_id_).first()
		db.session.delete(prod)
		db.session.commit()
	return redirect('/produtos')


@app.route('/produtos/view/<int:_id_>', methods=['GET'])
@login_required
def view_get_produtos(_id_):
    dados = Produtos.query.filter_by(id=_id_).first()
    return render_template('view_produto.tpl', dados=dados)

##############Construtor Pedidos############################
@app.route('/pedidos', methods=['GET','POST'])
@login_required
def ins_get_pedidos1():
	"""papel= Role.query.filter_by(name='Administrator').first()
    if current_user.role_id == papel.id:
        dados = Pedidos.query.all()
    else:
        dados = Pedidos.query.filter_by(user_id=current_user.id).all()
    return render_template('pedidos.tpl', dados=dados)	
	"""
	papel= Role.query.filter_by(name='Administrator').first()
	#if current_user.role_id == papel.id:
	
	if request.method == 'POST':
		data_ini = request.form.get('dataIni')
		print('DATA INICIO',data_ini)
		data_fim = request.form.get('dataFim')
		print('Data FIM', data_fim)
		#dados = Pedidos.query.filter_by(data=data_ini).filter_by(data_agendamento=data_fim).all()
		dados = Pedidos.query.filter(Pedidos.data.between(data_ini,data_fim))
		print('DADOS POST', dados)
	elif request.method == 'GET':
		print('REQUEST GET',request.form)
		dados = Pedidos.query.all()
		print('DADOS GET',dados)

	else:
		dados = Pedidos.query.filter_by(user_id=current_user.id).all()
	return render_template('pedidos.tpl', dados=dados)

@app.route('/pedidos/fazer', methods=['GET'])
@login_required
def ins_get_pedidos2():
    dados = Produtos.query.all()
    dadosFav = Favoritos.query.filter_by(usuarios_id=current_user.id).all()
    idsFav = [f.produtos_id for f in dadosFav]

    #TESTANDO AGENDAMENTO DE COMPRAS
    #dadosPed = Pedidos.query.filter_by(data_agendamento=)
    return render_template('fazer_pedido.tpl', dados=dados, dadosFav=dadosFav, idsFav=idsFav)

@app.route('/pedidos/fazer2', methods=['POST'])
@login_required
def ins_get_pedidos3():
    produtos = request.form.getlist("produto")
    dados = Produtos.query.filter(Produtos.id.in_(produtos)).all() #todos os produtos seleccionados no formulario anterior
    #print (produtos)#para ter uma visualização do que está sendo gravado

    #Teste agendamento
    agen = request.form.get("agendamento")
    print("agendamento", agen)

    return render_template('pedido_quant_valor.tpl', dados=dados, agen=agen)

@app.route('/pedidos/infopedido', methods=['POST'])
def inf_pedido():
    dados = Produtos.query.all()# testando para conseguir usar o dado do meu template info_pedido.tpl
    agen = request.form.get("agendamento")
    user_id=current_user.id
    
    ids    = request.form.getlist('id')
    precos = request.form.getlist('cont')
    qtdes  = request.form.getlist('quantidade')
    
    
    li    =[]
    total = 0
    for i in range(len(ids)):
        produto= Produtos.query.filter_by(id=ids[i]).first()
        tupla=(i,ids[i], precos[i],qtdes[i], float(precos[i])*int(qtdes[i]),produto.nome_produto)
        li.append(tupla)
        total  += float(precos[i])*int(qtdes[i])

    novo_pedido = Pedidos(total=total, user_id=current_user.id,data_agendamento=agen)
    db.session.add(novo_pedido)
    db.session.commit()
    print(novo_pedido.id)

    itens = []
    for i in range(len(ids)):
        novo_item = Itens(produtos_id=ids[i],pedidos_id=novo_pedido.id,quant=qtdes[i],valor=precos[i])
        itens.extend([novo_item])
        novo_item = ''
    novo_pedido.ped_itens.extend(itens)
    db.session.commit()
    flash("Pedido registrado com sucesso!","success")


    return render_template('info_pedidos.tpl',ped_id=novo_pedido.id ,dado=dados, dados=li, tamanho= range(len(ids)), total=total)

@app.route('/pedidos/consultar', methods=['GET'])
@login_required
def get_consultar():
    #dados = Pedidos.query.filter_by(user_id=current_user.id).all()
    dados = Pedidos.query.filter_by(user_id=current_user.id).order_by(-Pedidos.id).all() #Filtro eles para cada usuario e ordeno a ficar decrescente
    return render_template('consultar.tpl', dados=dados)

@app.route('/pedidos/edit/<int:_id_>', methods=['GET'])
def edit_get_pedidos(_id_):
    dados = Pedidos.query.filter_by(id=_id_).first()
    form = PedidosForm()
    return render_template('edit_pedidos.tpl', dado=dados, form=form)

@app.route('/pedidos/edit/<int:_id_>', methods=['POST'])
def edit_post_pedidos(_id_):
    ped = Pedidos.query.filter_by(id=_id_).first()
    print(ped)#para ter uma visualização do que está sendo gravado
    form = PedidosForm(obj=ped)     
    print (form.numero.data)
    if form.validate_on_submit():
        try:
            ped.nome_produto= form.numero.data
            ped.valor= form.total.data
            ped.data= form.data.data
            ped.pago= form.pago.data
            ped.liberado_entrega= form.liberado_entrega.data
            ped.entregue= form.entregue.data
            db.session.add(ped)
            db.session.commit()
            flash('Pedido editado!', 'success')
            print('sucesso')
        except Exception as e:
            flash ('erro'+e ,'danger')
            print('erro'+e)
    else:
        print('invalido', form.errors)
    return redirect('/pedidos')


@app.route('/pedidos/del/<int:_id_>', methods=['GET'])
def del_get_pedidos(_id_):
    dados = Pedidos.query.filter_by(id=_id_).first()
    return render_template('delete_pedidos.tpl', dados=dados)


@app.route('/pedidos/del/<int:_id_>', methods=['POST'])
def del_post_pedidos(_id_):
    ped = Pedidos.query.filter_by(id=_id_).first()
    print(ped)#para ter uma visualização do que está sendo gravado
    db.session.delete(ped)
    db.session.commit()
    return redirect('/pedidos')

@app.route('/pedidos/view/<int:_id_>', methods=['GET'])
def view_get_pedidos(_id_):
    dados = Pedidos.query.filter_by(id=_id_).first()
    return render_template('view_pedidos.tpl', dados=dados)
    

    
########### VERIFICAÇÃO  PAGAMENTO ############
@app.route('/atupedido/<int:_id_>', methods=['GET'])
@admin_required
def get_atupedido(_id_):
    dado = Pedidos.query.filter_by(id=_id_).first()
    print(dado)
    form = AtualizaPedidosForm()

    return render_template('atupedido.tpl', dado=dado, form=form)

@app.route('/atupedido2', methods=['POST'])
def post_atupedido():
    id = request.form.get('id')
    ped = Pedidos.query.filter_by(id=id).first()
    print(request.form)
    
    try:
        ped.pago=request.form.get('pago')
        ped.liberado_entrega=request.form.get('liberado_entrega')
        ped.entregue=request.form.get('entregue')
        print(ped.pago)
        print(ped.liberado_entrega)
        print(ped.entregue)
        if ped.pago == 'on':
            ped.pago = 1
        else:
            ped.pago = 0

        if ped.liberado_entrega == 'on':
            ped.liberado_entrega = 1
        else:
            ped.liberado_entrega = 0

        if ped.entregue == 'on':
            ped.entregue = 1
        else:
            ped.entregue = 0
        
        db.session.add(ped)
        db.session.commit()
    except Exception as e:
        flash('erro'+str(e), 'danger')
        print('erro'+str(e))
    return redirect('/pedidos')
#######################################
############FAVORITOS##################
@app.route('/favoritos')
def lista_favoritos_produtos():
    sql = text("""select produtos.id, produtos.nome_produto, produtos.valor, data_compra,eid,data_renova_compra from produtos
    left join (select data_compra,id as eid,produtos_id,data_renova_compra, max(data_compra) as empr from favoritos group by produtos_id)
    on produtos_id = produtos.id
    group by (produtos.id)""")
    dados = db.engine.execute(sql).fetchall()
    print(dados)
    return render_template('favorita_produto.tpl', dadostpl = dados)  

@app.route('/favoritosusuario/<_lid>')
def lista_favoritos_usuarios(_lid):
    dados = Usuario.query.all()
    return render_template('favoritos_usuarios.tpl', dadostpl = dados, livro_id=_lid)  




"""
@app.route('/emprestimoconfirma/<_uid>/<_lid>')

def lista_empr_confirma(_uid,_lid):
    usuario = Usuario.query.filter_by(id=_uid).first()
    livro   = Livro.query.filter_by(id=_lid).first()
    return render_template('livros/emprestimo_confirma.tpl', usuario=usuario, livro=livro)


@livros.route('/emprestimoefetua', methods=['POST'])

def lista_empr_efetua():
    empr = True
    try:
        U = request.form.get('id_usuario')
        L = request.form.get('id_livro')
        usuario = Usuario.query.filter_by(id=U).first()
        livro   = Livro.query.filter_by(id=L).first()
        livro.emprestado.append(usuario)
        livro.status = 1
        db.session.add(livro)
        db.session.commit()
        flash('Emprestado para o usuario [{}] o livro [{}] do autor [{}].'.format(usuario.nome,livro.titulo,livro.autor),'success')
    except Exception as e:
        flash('NÃO emprestado para o usuario {} o livro {} do autor {}.'.format(usuario.nome,livro.titulo,livro.autor), 'danger')
    return redirect(url_for('livros.lista_empr_livros'))

"""

#######################################
class AtualizaFavoritosForm(FlaskForm):
    favoritar = BooleanField('Favoritar', validators=[])
    botao = SubmitField('Atualizar Pedido')


@app.route('/favoritar', methods=['GET'])
@login_required
def get_fav():
    produtos = Produtos.query.all()
    my_sql= Template(""" SELECT p.id FROM produtos p
                    left join favoritos f 
                    on p.id = f.produtos_id
                    WHERE f.usuarios_id = $uid
                    """)

    sql_raw = my_sql.safe_substitute(uid=current_user.id)
    sql = text(sql_raw)
    result = db.engine.execute(sql)
    resultados = [row for row in result]
    #print ("resultados",resultados)
    li = []
    for i in resultados:
        li.append(i[0])
    #print ('lista',li)

    return render_template('favoritar.tpl', dados=li, produtos=produtos)

@app.route('/favoritar2', methods=['POST'])
def post_fav():
    favoritar = request.form.getlist("produto")
    print('Favoritar-Formulario',favoritar)
    try:    
        favorito = Favoritos.query.filter_by(usuarios_id=current_user.id).all()
        print('Favoritar', favoritar)
        print('REQUEST FORM', request.form)
        
        l =[f.produtos_id for f in favorito]
        print('L',l)
        for i in favoritar:
            i2 = int(i)
            print('I-FAVORITAR',i2)
            print('FAVORITO',favorito)


            if i2 not in l:
                print("ENTROU")
                print('TYPE-FAVORITO',type(i2))
                print('I-FAVORITO',i2)
                print('FAVORITO',l)
                novo_favorito = Favoritos(produtos_id=i2,usuarios_id=current_user.id)
                print("novo favorito", novo_favorito)
                db.session.add(novo_favorito)
                novo_favorito = ""
            else:
                print("nº{} já existe no banco ".format(i2))
        db.session.commit()
        

        # DELETAR 
        fav = [int(n) for n in favoritar] 
        print("FAV",fav)
        for d in l:
            print('D',d)
            print('TIPO- D',type(d))
            print('DEL - FAVORITO',l)
            print('TIPO- L',type(l))
            if d not in fav:
                print('TIPO- D- IF',type(d))
                print('TIPO- FAVORITAR IF',type(fav))
                f = Favoritos.query.filter_by(produtos_id=d).filter_by(usuarios_id=current_user.id).first()
                print('f',f)
                print('TIPO- F',type(f))
                db.session.delete(f)
            else:
                print("Beleza")
        db.session.commit()

        flash('Produto favoritado!','success')
        print('ok')
    except Exception as e:
        flash('Erro'+str(e),'danger')
        print('Erro '+str(e))

    return redirect('/favoritar')

############ RENOVAR PEDIDO #############
@app.route('/renovar-pedido/<int:_id>', methods=['GET'])
def post_renova_pedido(_id):
	dados = Pedidos.query.filter_by(id=_id).first()
	print('DADOS RENOVAR',dados)
	
	dados.data = date.today()
	print('Today',date.today())
	db.session.commit()

	return redirect('/pedidos')

#######################################

########### Relatório com mais informações do pedido (para o ADMIN) #############

@app.route('/relatorio/<int:_id>', methods=['GET'])
def get_relatorio(_id):
	my_sql = Template("""select usuarios.username,usuarios.endereco,pedidos.data,itens.quantidade,itens.valor_total,produtos.nome_produto,itens.produtos_id, pedidos.id, pedidos.total
				from pedidos
				left join itens
				on pedidos.id = itens.pedidos_id
				left join produtos
				on itens.produtos_id= produtos.id
				left join usuarios
				on pedidos.usuarios_id=usuarios.id
				where pedidos.id='$id' """)
	sql_raw = my_sql.safe_substitute(id=_id)
	sql = text(sql_raw)
	result = db.engine.execute(sql)
	dados = [row for row in result]
	print(dados)
	print('sql',sql)
	print('sql_raw',sql_raw)
	print('my_sql',my_sql)
	return render_template('relatorio.tpl', dadostpl=dados)
###########  Mais informações do pedido (para o USUARIO) #############

@app.route('/mais-informacoes/<int:_id>', methods=['GET'])
def get_mais_info(_id):
	my_sql = Template("""select usuarios.username,usuarios.endereco,pedidos.data,itens.quantidade,itens.valor_total,produtos.nome_produto,itens.produtos_id, pedidos.id, pedidos.total
				from pedidos
				left join itens
				on pedidos.id = itens.pedidos_id
				left join produtos
				on itens.produtos_id= produtos.id
				left join usuarios
				on pedidos.usuarios_id=usuarios.id
				where pedidos.id='$id' """)
	sql_raw = my_sql.safe_substitute(id=_id)
	sql = text(sql_raw)
	result = db.engine.execute(sql)
	dados = [row for row in result]
	print(dados)
	print('sql',sql)
	print('sql_raw',sql_raw)
	print('my_sql',my_sql)
	return render_template('mais-info.tpl', dadostpl=dados)

app.run(host='localhost', port=7000, debug=True)