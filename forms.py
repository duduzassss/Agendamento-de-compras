from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, validators
from wtforms.validators import DataRequired

class LoginForm (FlaskForm):
	email = StringField("email", validators=[DataRequired()])
	password = PasswordField("password",validators=[DataRequired()])
	remember_me = BooleanField("lembrar-me")


class RegistrationForm(FlaskForm):
	nome = StringField('Nome', [validators.Length(min=4, max=25)])
	telefone = StringField('Telefone', [validators.Length(min=11,max=11)])
	email = StringField('Email Address', [validators.Length(min=6, max=35)])
	senha = PasswordField('New Password', [
		validators.DataRequired(),
		validators.EqualTo('confirm', message='Passwords must match')
	])
	endereco = StringField('Endereço', [validators.Length(min=15,max=25)])
	cartao = StringField('Cartao de credito', [validators.Length(min=16,max=16),validators.DataRequired()])
	cpf = StringField('CPF', [validators.Length(min=11,max=11),validators.DataRequired()])