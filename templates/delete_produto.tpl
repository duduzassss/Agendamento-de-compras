{% extends 'bootstrap/base.html' %}
{% block title %}
	Deletar Produto
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
		<form method="POST" action="/produtos/del/{{dados.id}}" >
			<b><p>Nome do produto: {{dados.nome_produto}}</p></b>
			<b><p>Valor: {{dados.valor}}</p></b>
			
			<input class="btn btn-danger" type="submit" value="Deletar" style="font-weight: bold;"/>

			<a class="btn btn-info" href="/produtos" style="font-weight: bold;">
				Cancelar
			</a>
		</form>
	
{% endblock %}