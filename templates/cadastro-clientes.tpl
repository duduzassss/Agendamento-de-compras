% extends 'bootstrap/base.html'%}
{%import 'bootstrap/wtf.html' as wtf%}

{% block content %}
<h1>Cadastro Clientes</h1>
{{ wtf.quick_form(form) }}


{%endblock%}