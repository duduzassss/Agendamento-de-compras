<!--Este arquivo foi criado para teste, para ler as informações do banco de dados na web-->
<!DOCTYPE html>
<html lang='pt-br'>
<head>
	<title>Lista usuários</title>
	<meta charset='utf8'>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>Nome   	  |</th>
				<th>Senha 	  |</th>
				<th>Email 	  |</th>
			</tr>
		</thead>
		{% for dado in dados %}
		<tbody>
			<tr>
				<td>{{dado.username}}</td>
				<td>{{dado.password}}</td>
				<td>{{dado.email}}</td>
			</tr>
			{% endfor %}
		</tbody>
	</table>
</body>
</html>