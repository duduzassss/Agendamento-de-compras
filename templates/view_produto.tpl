{% extends 'bootstrap/base.html' %}
{% block title %}
	Visualizar Produtos
{% endblock %}

{% block styles %}
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
	<style type="text/css">
		h1{
			margin-left: 15px;
		}
		form{
			margin-left: 15px;
		}
		rs{
			color: green;
			font-weight: bold;
		}
		valor{
			font-size: 35px;
			color:green;
			font-weight: bold;
		}
	</style>
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
	
	 <h1>Visualizar</h1>
		<form method="GET" action="/produtos" >
			<p><strong>Nome do Produto:</strong> {{dados.nome_produto}}</p>
			<p><strong>Valor:</strong> <rs>R$<rs><valor>{{dados.valor}}</valor></p>
			<input type="submit" value="Voltar" class="btn btn-info" />


		</form>
{% endblock %}