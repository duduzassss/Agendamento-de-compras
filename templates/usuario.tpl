{% extends 'bootstrap/base.html' %}
{% block title %}
	Lista de Usuários
{% endblock %}

{% block styles %}
	
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
		
		<h1>Usuários</h1>
		{% with messages = get_flashed_messages(with_categories=true) %}
		  {% if messages %}
		    <ul class="flashes">
		    {% for category, message in messages %}
		      <li class="alert alert-{{ category }}">{{ message }}</li>
		    {% endfor %}
		    </ul>
		  {% endif %}
		{% endwith %}
		

		<div class="alert alert-primary"><strong>Para adicionar as informações como, telefone, endereço, cartão, entre outros, acesse a aba perfil.</strong> </div>

		<table class="table table-hover table-responsive">
			<tr>
				<th>Nome</th>
				<th>Email</th>
				<th>Telefone</th>
				<th>Endereço</th>
				<th>Cartão</th>
				<th>CPF</th>
				<th>Data de nascimento</th>
				<th style="text-align: center;">Ações</th>
			</tr>

			

			<tbody>
				{% for dado in dados %}
				<tr>

					<td>{{dado.username}}</td>
					<td>{{dado.email}}</td>
					<td>{{dado.telefone}}</td>
					<td>{{dado.endereco}}</td>
					<td>{{dado.cartao}}</td>
					<td>{{dado.cpf}}</td>
					<td>{{dado.nascimento}}</td>
					<td>
						<a class="btn btn-warning" href="/usuario/edit/{{dado.id}}">Editar</a>
						<a class="btn btn-info" href="/usuario/view/{{dado.id}}">Ver</a>
						<a class="btn btn-danger" href="/usuario/del/{{dado.id}}">Deletar</a>
						<a class="btn btn-secondary" href="/perfil/{{dado.id}}">Perfil</a>
					</td>
				</tr>
				{% endfor %}
			</tbody>
		</table>
{% endblock %}