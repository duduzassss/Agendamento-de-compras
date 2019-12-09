
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" href="/" style="font-style: italic; font-weight: bolder;">Shopping Schedule</a>
<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
  <span class="navbar-toggler-icon"></span>
</button>
<div class="collapse navbar-collapse" id="navbarsExampleDefault">
  <ul class="navbar-nav mr-auto">
   
    <li class="nav-item active">
      <a class="nav-link" href="/">Home<span class="sr-only">(current)</span></a>
    </li>
    {% if current_user.is_authenticated and current_user.is_administrator() %}
            <li class="nav-item active">
              <a class="nav-link" href="/pedidos">Pedidos<span class="sr-only">(current)</span></a>
            </li>
          {% else %}
            <li class="nav-item active">
              <a class="nav-link" href="/pedidos/fazer">Fazer pedido<span class="sr-only">(current)</span></a>
            </li>
          {% endif %}

          {% if current_user.is_authenticated and current_user.is_administrator() %}
            <li class="nav-item active">
              <a class="nav-link" href="/produtos">Produtos<span class="sr-only">(current)</span></a>
            </li>
          {% endif %}

          {% if current_user.is_authenticated and current_user.is_administrator() %}
          <li class="nav-item active">
            <a class="nav-link" href="/usuario">Usuarios<span class="sr-only">(current)</span></a>
          </li>
          {% else %}
          <li class="nav-item active">
            <a class="nav-link" href="/usuario">Perfil<span class="sr-only">(current)</span></a>
          </li>
          {% endif %}
          
          {% if current_user.is_authenticated and current_user.is_administrator() %}
          {% else %}
            <li class="nav-item active">
            <a class="nav-link" href="/pedidos/consultar">Consultar pedidos<span class="sr-only">(current)</span></a>
            </li>
          {% endif %}

          {% if current_user.is_authenticated and current_user.is_administrator() %}
          {% else %}
            <li class="nav-item active">
              <a class="nav-link" href="/favoritar">Favoritos<span class="sr-only">(current)</span></a>
            </li>
          {% endif %}
    
  </ul>
  </div>
    <form class="form-inline my-2 my-lg-0">
      <ul class="navbar-nav mr-auto">
      {% if current_user.is_anonymous %}
      <li class="nav-item active">
        <a class="nav-link" href="/login">Entrar <span class="sr-only">(current)</span></a>
      </li>
    {% endif %}
    {% if current_user.is_anonymous %}
      <li class="nav-item active">
        <a class="nav-link" href="/register">Registrar-se <span class="sr-only">(current)</span></a>
      </li>
    {% endif %}
    {% if current_user.is_authenticated %}
      <li class="nav-item active">
        <a class="nav-link" href="/logout">Sair <span class="sr-only">(current)</span></a>
      </li>
    {% endif %}
  </ul>
    </form>
</nav>
