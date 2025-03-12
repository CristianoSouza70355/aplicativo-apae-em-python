import tkinter as tk
from tkinter import ttk, messagebox

class AplicativoCadastroAlunos:
    def __init__(self, root):
        self.root = root
        self.root.title("Cadastro de Alunos APAE")

        self.alunos = []  # Lista para armazenar os dados dos alunos
        self.aluno_editando = None  # Variável para rastrear o aluno em edição

        self.criar_interface()
        self.atualizar_lista_alunos()

    def criar_interface(self):
        # Cadastro de Aluno
        ttk.Label(self.root, text="Nome:").grid(row=0, column=0)
        self.nome_entry = ttk.Entry(self.root)
        self.nome_entry.grid(row=0, column=1)

        ttk.Label(self.root, text="Matrícula:").grid(row=1, column=0)
        self.matricula_entry = ttk.Entry(self.root)
        self.matricula_entry.grid(row=1, column=1)

        ttk.Label(self.root, text="Contato:").grid(row=2, column=0)
        self.contato_entry = ttk.Entry(self.root)
        self.contato_entry.grid(row=2, column=1)

        ttk.Label(self.root, text="Documento:").grid(row=3, column=0)
        self.documento_entry = ttk.Entry(self.root)
        self.documento_entry.grid(row=3, column=1)

        ttk.Button(self.root, text="Cadastrar", command=self.cadastrar_aluno).grid(row=4, column=0, columnspan=2)

        # Pesquisa de Aluno
        ttk.Label(self.root, text="Pesquisar Aluno:").grid(row=5, column=0)
        self.pesquisa_entry = ttk.Entry(self.root)
        self.pesquisa_entry.grid(row=5, column=1)
        ttk.Button(self.root, text="Pesquisar", command=self.pesquisar_aluno).grid(row=5, column=2)

        # Presença
        ttk.Label(self.root, text="Data:").grid(row=6, column=0)
        self.data_entry = ttk.Entry(self.root)
        self.data_entry.grid(row=6, column=1)
        ttk.Button(self.root, text="Presente", command=self.marcar_presenca).grid(row=6, column=2)
        ttk.Button(self.root, text="Ausente", command=self.marcar_ausencia).grid(row=6, column=3)

        # Lista de Alunos
        self.lista_alunos = tk.Listbox(self.root, height=10, width=50)
        self.lista_alunos.grid(row=7, column=0, columnspan=4)

        # Botões de Edição e Exclusão
        ttk.Button(self.root, text="Editar", command=self.editar_aluno).grid(row=8, column=0)
        ttk.Button(self.root, text="Excluir", command=self.excluir_aluno).grid(row=8, column=1)

        # Relatórios
        ttk.Label(self.root, text="Relatórios:").grid(row=9, column=0)
        ttk.Label(self.root, text="Nome:").grid(row=10, column=0)
        self.relatorio_nome_entry = ttk.Entry(self.root)
        self.relatorio_nome_entry.grid(row=10, column=1)
        ttk.Label(self.root, text="Data:").grid(row=11, column=0)
        self.relatorio_data_entry = ttk.Entry(self.root)
        self.relatorio_data_entry.grid(row=11, column=1)
        ttk.Button(self.root, text="Gerar Relatório", command=self.gerar_relatorio).grid(row=11, column=2)

    def cadastrar_aluno(self):
        nome = self.nome_entry.get()
        matricula = self.matricula_entry.get()
        contato = self.contato_entry.get()
        documento = self.documento_entry.get()

        if self.aluno_editando is not None:
            # Atualizar aluno existente
            self.alunos[self.aluno_editando] = (nome, matricula, contato, documento)
            self.aluno_editando = None
        else:
            # Adicionar novo aluno
            self.alunos.append((nome, matricula, contato, documento))

        self.atualizar_lista_alunos()
        self.limpar_campos()

    def pesquisar_aluno(self):
        pesquisa = self.pesquisa_entry.get().lower()
        resultados = [aluno for aluno in self.alunos if pesquisa in aluno[0].lower()]
        self.lista_alunos.delete(0, tk.END)
        for aluno in resultados:
            self.lista_alunos.insert(tk.END, f"Nome: {aluno[0]}, Matrícula: {aluno[1]}, Contato: {aluno[2]}, Documento: {aluno[3]}")

    def marcar_presenca(self):
        # Implementar lógica para marcar presença
        pass

    def marcar_ausencia(self):
        # Implementar lógica para marcar ausência
        pass

    def atualizar_lista_alunos(self):
        self.lista_alunos.delete(0, tk.END)
        for aluno in self.alunos:
            self.lista_alunos.insert(tk.END, f"Nome: {aluno[0]}, Matrícula: {aluno[1]}, Contato: {aluno[2]}, Documento: {aluno[3]}")

    def gerar_relatorio(self):
        nome = self.relatorio_nome_entry.get()
        data = self.relatorio_data_entry.get()
        # Implementar lógica para gerar relatório
        pass

    def limpar_campos(self):
        self.nome_entry.delete(0, tk.END)
        self.matricula_entry.delete(0, tk.END)
        self.contato_entry.delete(0, tk.END)
        self.documento_entry.delete(0, tk.END)

    def editar_aluno(self):
        selecionado = self.lista_alunos.curselection()
        if selecionado:
            index = selecionado[0]
            aluno = self.alunos[index]
            self.nome_entry.delete(0, tk.END)
            self.matricula_entry.delete(0, tk.END)
            self.contato_entry.delete(0, tk.END)
            self.documento_entry.delete(0, tk.END)
            self.nome_entry.insert(0, aluno[0])
            self.matricula_entry.insert(0, aluno[1])
            self.contato_entry.insert(0, aluno[2])
            self.documento_entry.insert(0, aluno[3])
            self.aluno_editando = index
        else:
            messagebox.showerror("Erro", "Selecione um aluno para editar.")

    def excluir_aluno(self):
        selecionado = self.lista_alunos.curselection()
        if selecionado:
            index = selecionado[0]
            del self.alunos[index]
            self.atualizar_lista_alunos()
        else:
            messagebox.showerror("Erro", "Selecione um aluno para excluir.")

if __name__ == "__main__":
    root = tk.Tk()
    app = AplicativoCadastroAlunos(root)
    root.mainloop()
