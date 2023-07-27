# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Genre.create({ name: "飲み物"}) if !Genre.where(name: "飲み物").present?;
Genre.create({ name: "軽食・サイドメニュー"}) if !Genre.where(name: "軽食・サイドメニュー").present?;
Genre.create({ name: "パスタ"}) if !Genre.where(name: "パスタ").present?;
Genre.create({ name: "ごはん"}) if !Genre.where(name: "ごはん").present?;
Genre.create({ name: "デザート"}) if !Genre.where(name: "デザート").present?;
Genre.create({ name: "その他"}) if !Genre.where(name: "その他").present?;