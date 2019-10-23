<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<title>Editar</title>
		{% include 'menu_superior.tpl' %}
	</head>
	<body>
	 <h1>Editar</h1>
		
		
		<form method="POST" action="/pedidos/edit/{{dado.id}}">
		{{form.hidden_tag()}}
			<p>Numero do pedido:
		    {{form.numero}}
		    </p>
		    <p>Total:
		    {{form.total}}
		    </p>
		    <p>Data:
		   	{{form.data}}
		    </p>
		    <p>Pago:
		    {{form.pago}}
		    </p>
		    <p>Liberado entrega:
		    {{form.liberado_entrega}}
		    </p>
		    <p>Entregue:
		    {{form.entregue}}
		    </p>
    		<input type="submit" value="Atualizar pedido">
  		</form>
	
	</body>
</html>