module ApplicationHelper
  def translate_gender(user)
    options = { unspecified: 'Sin especificar', male: 'Masculino', female: 'Femenino' }
    options[user.gender.to_sym]
  end
end
