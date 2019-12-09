{% extends 'bootstrap/base.html' %}
{% block title %}
	Deletar Pedido
{% endblock %}

{% block styles %}
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
		<form method="POST" action="/pedidos/del/{{dados.id}}" >
			<p>Numero do pedido: {{dados.id}}</p>
			<p>Total: R$ {{dados.total}}</p>
			<p>Data: {{dados.data.strftime('%d/%m/%Y')}}</p>
			{% if dados.pago != 0%}
				<p>Pago: {{dados.pago}}</p>
			{% else %}
				<p>Pago: Não</p>
			{%endif%}
			{% if dados.liberado_entrega != 0%}
				<p>Liberado para entrega: {{dados.liberado_entrega}}</p>
			{% else %}
				<p>Liberado para entrega: Não</p>
			{% endif %}
			{% if dados.entregue != 0%}
				<p>Entregue: {{dados.entregue}}</p>
			{% else %}
				<p>Entregue: Não</p>
			{% endif %}
			<input type="submit" value="Deletar" class="btn btn-danger" style="font-weight: bold;"/>

			<a class="btn btn-info" href="/pedidos" style="font-weight: bold;">
				Cancelar
			</a>
		</form>
		
{% endblock %}