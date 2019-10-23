
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  
<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
  <span class="navbar-toggler-icon"></span>
</button>
<div class="collapse navbar-collapse" id="navbarsExampleDefault">
  <ul class="navbar-nav mr-auto">
   
    <li class="nav-item active">
      <a class="nav-link" href="/">Home<span class="sr-only">(current)</span></a>
    </li>
    <li class="nav-item active">
      <a class="nav-link" href="/pedidos">Pedidos<span class="sr-only">(current)</span></a>
    </li>
    <li class="nav-item active">
      <a class="nav-link" href="/produtos">Produtos<span class="sr-only">(current)</span></a>
    </li>
    <li class="nav-item active">
      <a class="nav-link" href="/usuario">Usuarios<span class="sr-only">(current)</span></a>
    </li>
    
    <li class="nav-item active">
      <a class="nav-link" href="/pedidos/consultar">Consultar compra<span class="sr-only">(current)</span></a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="/favoritar">Favoritos<span class="sr-only">(current)</span></a>
    </li>
    
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
  </div>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Pesquise aqui..." aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Pesquisar</button>
    </form>
</nav>
