User.create email: "testing@example.org", password: "123456789", password_confirmation: "123456789", enabled: true

News.create([
  {title: "Prueba de noticia", content: "Este es el contenido de un mensaje de ejemplo. Hasta 250 caracteres.", public: true},
  {title: "Prueba de noticia 2", content: "Este es el contenido de un mensaje de ejemplo. Hasta 250 caracteres.", public: true}
])
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role: 'administrador') if Rails.env.development?
