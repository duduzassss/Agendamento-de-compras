{% extends 'bootstrap/base.html' %}
{% block title %}
	Deletar
{% endblock %}

{% block styles %}
	<style type="text/css">
		h1{
			background-color:red;
			text-align: center;
			width: 280px;
		}
	</style>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}

{% block content %}
{% include 'menu_superior.tpl' %}
	 <h1> Tem certeza que quer deletar?</h1>
		<form method="POST" action="/usuario/del/{{dados.id}}" >
			<p>Nome: {{dados.username}}</p>
			<p>Telefone: {{dados.telefone}}</p>
			<p>Email: {{dados.email}}</p>
			<p>Endereco: {{dados.endereco}}</p>
			<p>Cartao: {{dados.cartao}}</p>
			<p>CPF: {{dados.cpf}}</p>
			<p>Data de nascimento: {{dados.nascimento}}</p>
			<input type="submit" value="Deletar" style="background-color: #FF0033;font-size: 16px;font-weight: bold; color: white;" />

		</form>
		<br>
		<form method="GET" action="/usuario">
			<input type="submit" value="Cancelar" style="background-color: blue; font-size: 16px; font-weight: bold; color: white;" />
		</form>
{% endblock %}