module PrettyCommission
  def pretty
    {
      insurance_fee: to_insurance,
      assistance_fee: to_assistance,
      drivy_fee: to_drivy
    }
  end
end