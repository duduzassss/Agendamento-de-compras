{% extends 'bootstrap/base.html' %}
{% import 'bootstrap/wtf.html' as wtf %}
{% block title %}
	Gravando Pedido
{% endblock %}
{% block styles %}
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}

{% block content %}
{% include 'menu_superior.tpl' %}

	 <h1>As seguintes informações do seu pedido a serem gravadas, são as seguintes:</h1>

	<div class="row">
	<div class="col-md-6">
		<form action="{{url_for('finaliza_pagamento')}}" method="POST">
	<table id="pedidos" class="table table-stripped">
		<thead>
			<tr>
				<th>Numero do pedido</th>
				<th>Total</th>
				<th>Quantidade</th>
				<th>Data</th>
			</tr>
		</thead>
	<tbody>
		{% for dado in dados %}
		<tr>
			<td>
				<input type="text" name="id" value="{{dado.id}}" readonly="readonly" />
				<!--{{dado.id}}-->
			</td>
			<td>
				<input type="text" id="total" name="total" readonly="readonly" value="{{dado.total}}"/>
				<!--{{dado.total}}-->
			</td>
			<td>
				<input type="text" id="quant" name="quant" readonly="readonly" value="{{dado.quant}}"/>
				<!--{{dado.quant}}-->
			</td>
			<td>
				<input type="text" id="data" name="data" readonly="readonly" value="{{dado.data}}"/>
				<!--{{dado.data}}-->
			</td>
		</tr>
		{% endfor %}
	</tbody>
	</table>
<div style="float: left;">
	<a href="/atupagamento1" class="btn btn-info">Voltar</a>
	<input type="submit" value="Avançar" class="btn btn-success">
</div>
	</form>
</div>
</div>
{% endblock %}


{% block scripts %}
	<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	<script>
		$( document ).ready(function() {
		var $tblrows = $("#pedidos tbody tr");
		
		$tblrows.each(function (index) {
			var $tblrow = $(this);
			$tblrow.find('.quantidade').load('',function () {
			 
			var qty = $tblrow.find("[name=quantidade]").val();
			console.log(qty);
		
			var price = $tblrow.find("[name=cont]").val();
			console.log(price);
			var subTotal = parseInt(qty,10) * parseFloat(price);
			console.log(subTotal);

			if (!isNaN(subTotal)) {
				$tblrow.find('.subtot').html(subTotal.toFixed(2));
				$tblrow.find('.subtot').val(subTotal.toFixed(2));
				var grandTotal= 0;
				$(".subtot").each(function () {
					var stval = parseFloat($(this).val());
					grandTotal += isNaN(stval) ? 0 : stval;
				});
				$('#total').html(grandTotal.toFixed(2));

			}
			});
			$tblrow.find('.quantidade').on('input', function () {
			 
			var qty = $tblrow.find("[name=quantidade]").val();
			console.log(qty);
		
			var price = $tblrow.find("[name=cont]").val();
			console.log(price);
			var subTotal = parseInt(qty,10) * parseFloat(price);
			console.log(subTotal);

			if (!isNaN(subTotal)) {
				$tblrow.find('.subtot').html(subTotal.toFixed(2));
				$tblrow.find('.subtot').val(subTotal.toFixed(2));
				var grandTotal= 0;
				$(".subtot").each(function () {
					var stval = parseFloat($(this).val());
					grandTotal += isNaN(stval) ? 0 : stval;
				});
				$('#total').html(grandTotal.toFixed(2));

			}
			});
		});

	});
	</script>
{% endblock %}
