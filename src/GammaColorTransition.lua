-- Allows for linear interpolation between two colors using a specified Gamma value.

-- Utility function to apply a power to Color3
function PowColor3(Color, Pow)
    return Color3.new(math.pow(Color.r, Pow), math.pow(Color.g, Pow), math.pow(Color.b, Pow))
end

-- Interpolate between 'ColorA' and 'ColorB' by 'Frac' percentage with an optional 'Gamma' value. 
-- Typical gamma values range from 1.8 to 2.2. The default value is 2.0.
function LerpColor(ColorA, ColorB, Frac, Gamma)
    local Gamma = Gamma or 2.0
    
    local CA = PowColor3(ColorA, Gamma)
    local CB = PowColor3(ColorB, Gamma)
    return PowColor3(CA:lerp(CB, Frac), 1/Gamma)
end
