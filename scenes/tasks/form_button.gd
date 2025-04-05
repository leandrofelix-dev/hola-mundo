extends Button
func _on_Button_pressed():
	var nome = $VBoxContainer/LineEdit.text
	var mensagem = $VBoxContainer/TextEdit.text
	print("Nome:", nome)
	print("Mensagem:", mensagem)
