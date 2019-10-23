<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<title>Deletar</title>
	</head>
	<body>
	 
	 <h1 style="background-color:red;color:white; text-align: center;width: 280px;"> Tem certeza que quer deletar?</h1>
		<form method="POST" action="/pedidos/del/{{dados.id}}" >
			<p>Numero do pedido: {{dados.numero}}</p>
			<p>Total: {{dados.total}}</p>
			<p>Data: {{dados.data}}</p>
			<p>Pago: {{dados.pago}}</p>
			<p>Liberado para entrega? {{dados.liberado_entrega}}</p>
			<p>Entregue? {{dados.entregue}}</p>
			<input type="submit" value="Deletar" style="background-color: #FF0033;font-size: 16px;font-weight: bold; color: white;" />

		</form>
		<br>
		<form method="GET" action="/pedidos">
			<input type="submit" value="Cancelar" style="background-color: blue; font-size: 16px; font-weight: bold; color: white;" />
		</form>
	</body>
</html>