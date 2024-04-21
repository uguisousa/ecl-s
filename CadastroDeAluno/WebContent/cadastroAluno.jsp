<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.js"
	integrity="sha512-+k1pnlgt4F1H8L7t3z95o3/KO+o78INEcXTbnoJQ/F2VqDVhWoaiVml/OEHv9HsVgxUaVW+IbiZPUJQfF/YxZw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<script>
	function exibirModal(mensagem) {
		document.getElementById("mensagemModal").innerHTML = mensagem;
		$('#ResultadoModal').modal('toggle');
	}
	function fecharModal(){
		$('#ResultadoModal').modal('toggle');
	}

	function editar(ra, nome, curso) {
		document.getElementById("ra").value = ra;
		document.getElementById("nome").value = nome;
		document.getElementById("curso").value = curso;
	}

	function excluir(ra) {
		var json   = {};
		json.ra    = ra;
		json.nome  = "";
		json.curso = "";
		json.senha = "";
		
		json.acao  = "excluir";
		
		$.ajax({
			url : "ServletAluno",
			data : json,
			type : "get",
			success : function(msg) {
				exibirModal(msg);
				buscar();
			}
		});
	}

	function salvar() {
		
		var json   = {};		
		json.ra    = document.getElementById("ra").value;
		json.nome  = document.getElementById("nome").value;
		json.curso = document.getElementById("curso").value;
		json.senha = document.getElementById("senha").value;
		
		if (json.ra!="" && json.ra!=null){
			json.acao  = "alterar";	
		}else{
			json.acao  = "inserir";
		}
		
		$.ajax({
			url : "ServletAluno",
			data : json,
			type : "get",
			success : function(msg) {
				exibirModal(msg);
				buscar();
				document.getElementById("formCadastro").reset();
			}
		});
	}

	function buscar() {
		var json   = {};		
		json.ra    = document.getElementById("ra").value;
		json.nome  = document.getElementById("nome").value;
		json.curso = document.getElementById("curso").value;
		json.senha = "";
		
		json.acao  = "consultar";	
		
		$.ajax({
			url : "ServletAluno",
			data : json,
			type : "get",
			success : function(resp) {
				var jsonResp = JSON.parse(resp);
				if (!Array.isArray(jsonResp)){
					exibirModal(jsonResp);	
				}else{
					var linhas = "";
					for (i=0;i<jsonResp.length;i++){
						var ra    = jsonResp[i].ra;
						var nome  = jsonResp[i].nome;
						var curso = jsonResp[i].curso;
						linhas += montarLinhaHTML(ra, nome, curso); 
					}
					document.getElementById("corpoDaTabela").innerHTML = linhas;
				}			
			}
		});
	}
	
	function montarLinhaHTML(raAluno, nomeAluno, cursoAluno){
		var linha = `<tr>
						<th><img src="imagens/edit.png"
							onClick="editar('` + raAluno + `','` + nomeAluno + `','` + cursoAluno + `')" /></th>
						<th><img src="imagens/delete.png" onClick="excluir('` + raAluno + `')"/></th>
						<td class="text-start">` + raAluno    + `</td>
						<td class="text-start">` + nomeAluno  + `</td>
						<td class="text-start">` + cursoAluno + `</td>
					</tr>`;
		return linha;
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
						<form id="formCadastro">
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
									<button type="button" class="btn btn-primary mb-3" onClick="buscar()">Buscar</button>
									<button type="button" class="btn btn-primary mb-3" onClick="salvar()">Salvar</button>
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
							<tbody id="corpoDaTabela">
								<!-- 
								<tr>
									<th><img src="imagens/edit.png"
										onClick="editar('1','Leandro','tads')" /></th>
									<th><img src="imagens/delete.png" /></th>
									<td class="text-start">1</td>
									<td class="text-start">Leandro</td>
									<td class="text-start">TADS</td>
								</tr>
								<tr>
									<th><img src="imagens/edit.png"
										onClick="editar('2','João','Engenharia')" /></th>
									<th><img src="imagens/delete.png" /></th>
									<td class="text-start">2</td>
									<td class="text-start">João</td>
									<td class="text-start">Engenharia</td>
								</tr>
								<tr>
									<th><img src="imagens/edit.png"
										onClick="editar('3','Pedro','Matemática')" /></th>
									<th><img src="imagens/delete.png" /></th>
									<td class="text-start">3</td>
									<td class="text-start">Pedro</td>
									<td class="text-start">Matemática</td>
								</tr>
								-->
							</tbody>
						</table>
					</div>
				</div>

			</div>
			<div class="col"></div>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal" id="ResultadoModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Resultado da
						solicitação</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" id="mensagemModal">...</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						onClick="fecharModal()">Ok</button>
				</div>
			</div>
		</div>
	</div>




	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
		integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
		crossorigin="anonymous"></script>
</body>
</html>