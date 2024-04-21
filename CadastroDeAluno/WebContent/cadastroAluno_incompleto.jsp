<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
	
	<script>
		function editar(ra,nome,curso){
			document.getElementById("ra").value = ra;
			document.getElementById("nome").value = nome;
			document.getElementById("curso").value = curso;
		}
		
		
	</script>
</head>
<body>
	<div class="container text-center">
		<div class="row mt-3 p-0">

			<div class="col-6 offset-3 p-0">
				<img src="imagens/uninove.png" style="width: 60%; height: 80px">
			</div>

		</div>
		<div class="row mt-1">
			<div class="col"></div>
			<div class="col-8">

				<div class="row mt-3 p-0">
					<div class="col-8 offset-2">
						<form>
							<div class="row g-2 align-items-center">
								<div class="col-auto">
									<label for="ra" class="col-form-label">RA.......:</label>
								</div>
								<div class="col w-100">
									<input type="text" id="ra" class="form-control"
										style="width: 100%" disabled>
								</div>
							</div>
							<div class="row g-2 align-items-center">
								<div class="col-auto">
									<label for="nome" class="col-form-label">Nome:</label>
								</div>
								<div class="col w-100">
									<input type="text" id="nome" class="form-control">
								</div>
							</div>
							<div class="row g-2 align-items-center">
								<div class="col-auto">
									<label for="curso" class="col-form-label">Curso.:</label>
								</div>
								<div class="col w-100">
									<input type="text" id="curso" class="form-control">
								</div>
							</div>
							<div class="row g-2 align-items-center">
								<div class="col-auto">
									<label for="senha" class="col-form-label">Senha:</label>
								</div>
								<div class="col w-100">
									<input type="password" id="senha" class="form-control">
								</div>
							</div>

							<div class="row g-2 align-items-center mt-3">
								<div class="col-auto">
									<button type="button" class="btn btn-primary mb-3">Buscar</button>
									<button type="button" class="btn btn-primary mb-3">Salvar</button>
									<button type="reset" class="btn btn-primary mb-3">Limpar</button>
								</div>
							</div>
						</form>
					</div>
				</div>


				<div class="row align-items-center mt-2">
					<div class="col w-100">

						<table class="table caption-top">
							<thead>
								<tr>
									<th scope="col">Editar</th>
									<th scope="col">Excluir</th>
									<th scope="col" class="text-start">RA</th>
									<th scope="col" class="text-start">Nome</th>
									<th scope="col" class="text-start">Curso</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th><img src="imagens/edit.png" onClick="editar('1','Leandro','tads')"/></th>
									<th><img src="imagens/delete.png" /></th>
									<td class="text-start">1</td>
									<td class="text-start">Leandro</td>
									<td class="text-start">TADS</td>
								</tr>
								<tr>
									<th><img src="imagens/edit.png" onClick="editar('2','João','Engenharia')"/></th>
									<th><img src="imagens/delete.png" /></th>
									<td class="text-start">2</td>
									<td class="text-start">João</td>
									<td class="text-start">Engenharia</td>
								</tr>
								<tr>
									<th><img src="imagens/edit.png" onClick="editar('3','Pedro','Matemática')"/></th>
									<th><img src="imagens/delete.png" /></th>
									<td class="text-start">3</td>
									<td class="text-start">Pedro</td>
									<td class="text-start">Matemática</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

			</div>
			<div class="col"></div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>