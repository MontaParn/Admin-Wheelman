# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

[
  { name: "วิ่ง+ว่าย+ปั่น รายปี", run: true, swim: true, bike: true, billing_cycle: :annual, duration_days: 365, price: 30_000 },
  { name: "วิ่ง+ว่าย+ปั่น ราย 6 เดือน", run: true, swim: true, bike: true, billing_cycle: :semi_annual, duration_days: 182, price: 18_000 },
  { name: "วิ่งอย่างเดียว รายปี", run: true, swim: false, bike: false, billing_cycle: :annual, duration_days: 365, price: 10_000 },
  { name: "วิ่งอย่างเดียว รายเดือน", run: true, swim: false, bike: false, billing_cycle: :monthly, duration_days: 30, price: 1_200 }
].each do |attrs|
  PackagePlan.find_or_create_by!(name: attrs[:name]) do |plan|
    plan.assign_attributes(attrs.except(:name))
  end
end
