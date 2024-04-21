package controller;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.sqlite.SQLiteConfig;

import com.google.gson.Gson;

import model.aluno.AlunoBean;

/**
 * Servlet implementation class ServletAluno
 */
@WebServlet("/ServletAluno")
public class ServletAluno extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletAluno() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF8");

		try {
			Class.forName("org.sqlite.JDBC");

			String diretorio = System.getProperty("wtp.deploy").toString().split(".metadata")[0];
			String dataBase = diretorio + "\\uninove.db";
			
			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + dataBase);

			Statement stm = conn.createStatement();
			// wstm.executeUpdate("DROP TABLE IF EXISTS aluno");
			stm.executeUpdate(
					"CREATE TABLE IF NOT EXISTS 'aluno'('ra' INTEGER, 'nome' TEXT, 'curso' TEXT, 'senha' TEXT, PRIMARY KEY('ra' AUTOINCREMENT))");

			AlunoBean al = new AlunoBean();

			int ra = (request.getParameter("ra") == null || request.getParameter("ra").equals("") ? -1
					: Integer.valueOf(request.getParameter("ra")));
			al.setRa(ra);
			al.setNome(request.getParameter("nome"));
			al.setCurso(request.getParameter("curso"));
			// al.setSenha(request.getParameter("senha"));

			/*C贸digo para criptografar a senha */
			String senha = request.getParameter("senha");
			MessageDigest m = MessageDigest.getInstance("MD5");
			m.update(senha.getBytes(), 0, senha.length());
			senha = new BigInteger(1, m.digest()).toString(16);
			/*Fim do c贸digo para criptografar a senha */
			
			al.setSenha(senha);

			String acao = request.getParameter("acao");

			if (acao.equals("inserir")) {
				String sql = "insert into aluno(ra,nome,curso,senha) values (null,?,?,?)";
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setString(1, al.getNome());
				pstm.setString(2, al.getCurso());
				pstm.setString(3, al.getSenha());
				pstm.executeUpdate();
				pstm.close();

				String msg = "Registro salvo com sucesso!";
				Gson gson = new Gson();
				response.getWriter().append(gson.toJson(msg));

			} else if (acao.equals("consultar")) {
				PreparedStatement pstm = conn.prepareStatement("select * from aluno");
				ResultSet rs = pstm.executeQuery();
				List<AlunoBean> listAluno = new ArrayList<AlunoBean>();
				while (rs.next()) {
					AlunoBean aluno = new AlunoBean();
					aluno.setRa(rs.getInt("ra"));
					aluno.setNome(rs.getString("nome"));
					aluno.setCurso(rs.getString("curso"));
					listAluno.add(aluno);
				}
				pstm.close();

				Gson gson = new Gson();
				response.getWriter().append(gson.toJson(listAluno));

			} else if (acao.equals("alterar")) {
				String sql = "update aluno set nome=?, curso=?, senha=? where ra=?";
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setString(1, al.getNome());
				pstm.setString(2, al.getCurso());
				pstm.setString(3, al.getSenha());
				pstm.setInt(4, al.getRa());
				pstm.executeUpdate();
				pstm.close();

				String msg = "Registro alterado com sucesso!";
				Gson gson = new Gson();
				response.getWriter().append(gson.toJson(msg));

			} else if (acao.equals("excluir")) {
				String sql = "delete from aluno where ra=?";
				PreparedStatement pstm = conn.prepareStatement(sql);
				pstm.setInt(1, al.getRa());
				pstm.executeUpdate();
				pstm.close();

				String msg = "Registro exclu韉o com sucesso!";
				Gson gson = new Gson();
				response.getWriter().append(gson.toJson(msg));
			}
			conn.close();

		} catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block

			String msg = "Houve um erro ao executar a opera玢o!<br><br>ERRO: " + e.getMessage();
			Gson gson = new Gson();
			response.getWriter().append(gson.toJson(msg));
		}

		// response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	public static void main(String[] args) {

		// O c贸digo abaixo 茅 s贸 para testar a classe Gson que converte objeto para json

		AlunoBean aluno1 = new AlunoBean();
		aluno1.setRa(1);
		aluno1.setNome("Maria");
		aluno1.setCurso("ADS");

		AlunoBean aluno2 = new AlunoBean();
		aluno2.setRa(2);
		aluno2.setNome("Carlos");
		aluno2.setCurso("Enfermagem");

		List<AlunoBean> listAluno = new ArrayList<AlunoBean>();
		listAluno.add(aluno1);
		listAluno.add(aluno2);

		Gson gson = new Gson();
		System.out.println("Json simples: " + gson.toJson(aluno1));
		System.out.println("Json array..: " + gson.toJson(listAluno));

		File currDir = new File("uninove.db");
		String path = currDir.getAbsolutePath();
		System.out.println(path);

	}
}
