# Crea 2 usuarios de prueba
if User.all.empty?
  User.create([
    {
      username: 'admin',
      password: 'admin'
    },
    {
      username: 'juan',
      password: '123456'
    }
  ])
end


# Crea 20 productos (con código y precio aleatorio)
if Product.all.empty?
  (1..20).each do |i|
    Product.create({
      code: (0...3).map { (65 + rand(26)).chr }.join + (0...6).map { rand(9) }.join,
      description: "Producto #{i}",
      detail: "Detalles más extensos del producto #{i}",
      price: rand(0.0..9999.0).truncate(2)
    })
  end
end


# Crea 20 items disponibles para el primer y segundo producto
if Item.all.empty?
    20.times do
      Item.create( {status: 0, product: Product.all.first} )
      Item.create( {status: 0, product: Product.all.second} )
    end
end


# Crea las condiciones ante IVA, respetando los tipos de responsables de la AFIP
if VatCondition.all.empty?
  VatCondition.create([
      {code: 1, description: "IVA Responsable Inscripto"},
      {code: 2, description: "IVA Responsable no Inscripto"},
      {code: 3, description: "IVA no Responsable"},
      {code: 4, description: "IVA Sujeto Exento"},
      {code: 5, description: "Consumidor Final"},
      {code: 6, description: "Responsable Monotributo"},
      {code: 7, description: "Sujeto no Categorizado"},
      {code: 8, description: "Proveedor del Exterior"},
      {code: 9, description: "Cliente del Exterior"},
      {code: 10, description: "IVA Liberado – Ley Nº 19.640"},
      {code: 11, description: "IVA Responsable Inscripto – Agente de Percepción"},
      {code: 12, description: "Pequeño Contribuyente Eventual"},
      {code: 13, description: "Monotributista Social"},
      {code: 14, description: "Pequeño Contribuyente Eventual Social"}
  ]);
end


# Crea 2 clientes
if Client.all.empty?
  Client.create([
    {
      cuit_cuil: '21282557142',
      email: 'en_gomez@edu.ar',
      denomination: 'Enrique Gomez',
      vat_condition: VatCondition.find_by(code: 5)
    },
    {
      cuit_cuil: '23275974231',
      email: 'damigon87@edu.ar',
      denomination: 'Damian Gonzalez',
      vat_condition: VatCondition.find_by(code: 13)
    }
  ])
end