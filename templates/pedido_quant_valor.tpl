{% extends 'bootstrap/base.html' %}
{% import 'bootstrap/wtf.html' as wtf %}
{% block title %}
	Fazer Pedido
{% endblock %}
{% block styles %}
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
	<style type="text/css">
		h1{
			margin-left: 15px;
		}
	</style>
{% endblock %}

{% block content %}
{% include 'menu_superior.tpl' %}

	 <h1>Escolha a quantidade e o valor do seu pedido</h1>

	<div class="row">
	<div class="col-md-6">
		<form action="{{url_for('inf_pedido')}}" method="POST">
	<table id="produtos" class="table table-stripped">
		<thead>
			<tr>
				<th>ID</th>
				<th>Produtos</th>
				<th>Quantidade</th>
				<th>Valor Unidade</th>
				<th>Subtotal</th>
			</tr>
		</thead>
	<tbody>
		{% for dado in dados %}
		<tr>
			<td><input type="text" name="id" value="{{dado.id}}" readonly="readonly" /></td>
			<td>
				{{dado.nome_produto}}
			</td>
			<td>
				<input type="number" class="cont prc quantidade" id="quantidade" name="quantidade" value="1" min="1" />
			</td>
			<td><input type="text" id="cont" name="cont" readonly="readonly" value="{{dado.valor}}"/></td>
			
			<td class="subtot">{{dado.valor}}</td>
			<td><input type="hidden" name="agendamento" value="{{agen}}"></td>
		</tr>
		{% endfor %}
		<tr><td colspan="4" >TOTAL</td><td id="total"></td></tr>
	</tbody>
	</table>
<div style="float: left;">
	<a href="/pedidos/fazer" class="btn btn-info">Voltar</a>
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
		var $tblrows = $("#produtos tbody tr");
		
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
