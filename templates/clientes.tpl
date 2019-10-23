<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<title>Lista clientes</title>
	</head>
	<body>
		<h1>CLIENTES</h1>
		{% with messages = get_flashed_messages(with_categories=true) %}
		  {% if messages %}
		    <ul class="flashes">
		    {% for category, message in messages %}
		      <li class="alert alert-{{ category }}">{{ message }}</li>
		    {% endfor %}
		    </ul>
		  {% endif %}
		{% endwith %}
		<a href="/clientes/ins">Inserir </a>
		<table>
			<thead>
				<tr>
					<th>id		  |</th>
					<th>Nome   	  |</th>
					<th>Telefone  |</th>
					<th>Email  	  |</th>
					<th>Senha  	  |</th>
					<th>Endereco  |</th>
					<th>Cartao    |</th>
					<th>Cpf  	  |</th>
					<th>Ações</th>
				</tr>
			</thead>
			<tbody>
				{% for dado in dados %}
				<tr>
					<td>{{dado.nome}}</td>
					<td>{{dado.telefone}}</td>
					<td>{{dado.email}}</td>
					<td>{{dado.senha}}</td>
					<td>{{dado.confirm}}</td>
					<td>{{dado.endereco}}</td>
					<td>{{dado.cartao}}</td>
					<td>{{dado.cpf}}</td>
					<td><a href="/clientes/edit/{{dado[0]}}">Editar</a><a href="/clientes/view/{{dado[0]}}">Ver</a><a href="/clientes/del/{{dado[0]}}">Deletar</a></td>
				</tr>
				{% endfor %}
			</tbody>
		</table>
	</body>
</html>
