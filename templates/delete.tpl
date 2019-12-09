{% extends 'bootstrap/base.html' %}
{% block title %}
	Deletar
{% endblock %}

{% block styles %}
	<style type="text/css">
		p{
			font-size: 17px;
		}
	</style>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}

{% block content %}
{% include 'menu_superior.tpl' %}
	<div class="alert alert-danger" style="margin-right: 630px; font-size: 30px; color:red;">
  		<strong>Tem certeza que deseja deletar?</strong>
	</div>
		<form method="POST" action="/usuario/del/{{dados.id}}" >
			<p>Nome: {{dados.username}}</p>
			<p>Telefone: {{dados.telefone}}</p>
			<p>Email: {{dados.email}}</p>
			<p>Endereco: {{dados.endereco}}</p>
			<p>Cartao: {{dados.cartao}}</p>
			<p>CPF: {{dados.cpf}}</p>
			<p>Data de nascimento: {{dados.nascimento}}</p>
			<input type="submit" value="Deletar" class="btn btn-danger" style="font-weight: bold;" />

			<a class="btn btn-info" href="/usuario" style="font-weight: bold;">
				Cancelar
			</a>
		</form>
		
			
	
{% endblock %}