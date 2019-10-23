<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<title>Ver</title>
	</head>
	<body>
	 <h1>Visualizar</h1>
		<form method="GET" action="/pedidos" >
			<p>Numero do pedido: {{dados.numero}}</p>
			<p>Total: {{dados.total}}</p>
			<p>Data: {{dados.data}}</p>
			<p>Pago: {{dados.pago}}</p>
			<p>Liberado para entrega: {{dados.liberado_entrega}}</p>
			<p>Entregue: {{dados.entregue}}</p>
			<input type="submit" value="Voltar" />
		</form>
	</body>
</html>