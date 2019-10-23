{% extends 'bootstrap/base.html' %}
{% block title %}
	Visualização de Perfil
{% endblock %}
{% block styles %}
	
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
	 <h1>Visualizar</h1>
		<form method="GET" action="/usuario" >
			<p>Nome: {{dados.username}}</p>
			<p>Telefone: {{dados.telefone}}</p>
			<p>Email: {{dados.email}}</p>
			<p>Endereço: {{dados.endereco}}</p>
			<p>Cartão: {{dados.cartao}}</p>
			<p>CPF: {{dados.cpf}}</p>
			<p>Data de nascimento: {{dados.nascimento}}</p>
			<input type="submit" value="Voltar" />
		</form>
{% endblock %}