{% extends 'bootstrap/base.html' %}
{% import 'bootstrap/wtf.html' as wtf %}
{% block content %}

	 <h1>Informações do seu pedido</h1>
		
	<table border="solid">
		<tbody>
			<tr>
				<th>Número do pedido</th>

				<th>Total</th>

				<th>Quantidade</th>

				<th>Data</th>

				
			</tr>
		</tbody>
	
	{% if request.method == 'POST' %}
	<tbody>
		{% for i in tamanho %}
			<tr>
				<td>{{ dados[i][1] }}</td>
				<td>{{ dados[i][2] }}</td>
				<td>{{ dados[i][3] }}</td>
				<td>{{ dados[i][4] }}</td>
				<td>{{ dados[i][5] }}</td>
			</tr>
		{% endfor %}
	</tbody>
	{% endif %}
	</table>
	
	<table border="solid" style="margin-left: 165px;float: left; margin-top: -30px;">
		
	</table>
	<!--
	<a href="/pedidos/fazer">
	<input type="submit" value="Voltar">
	</a>
	<input type="submit" value="Confirmar compra">
	-->
{% endblock %}