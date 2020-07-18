module PermitParams
  class GeocodeParams < Dry::Validation::Contract

    params do
      required(:city).filled(:string)
    end

  end
end
