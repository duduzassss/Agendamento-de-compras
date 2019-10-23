{% extends 'bootstrap/base.html' %}
{% block title %}
	Produtos
{% endblock %}

{% block styles %}
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">

	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">


	{{super()}}
{% endblock %}

{% block content %}
{% include 'menu_superior.tpl' %}
	
		<h1>Produtos</h1>
		{% with messages = get_flashed_messages(with_categories=true) %}
		  {% if messages %}
		    <ul class="flashes">
		    {% for category, message in messages %}
		      <li class="alert alert-success">{{ message }}</li>
		    {% endfor %}
		    </ul>
		  {% endif %}
		{% endwith %}
		<a class="btn btn-success" href="/produtos/ins">Inserir produto</a><br/><br/>
		<table class="table table-hover">
			<tr>
				<th>Nome do produto</th>
				<th>Valor R$</th>

				<th>Ações</th>
			</tr>

			

			<tbody>
				{% for dado in dados %}
				<tr>

					<td>{{dado.nome_produto}}</td>
					<td>{{dado.valor}}</td>
					
					<td>
						<a class="btn btn-warning" href="/produtos/edit/{{dado.id}}">Editar</a>
						<a class="btn btn-info" href="/produtos/view/{{dado.id}}">Ver</a>
						<a class="btn btn-danger" href="/produtos/del/{{dado.id}}">Deletar</a>
					
					</td>
				</tr>
				{% endfor %}
			</tbody>
		</table>
	{% endblock %}
