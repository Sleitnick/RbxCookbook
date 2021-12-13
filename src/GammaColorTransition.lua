-- Allows for linear interpolation between two colors using a specified Gamma value.

-- Utility function to apply a power to Color3
local function PowColor3(color: Color3, pow: number): Color3
    return Color3.new(math.pow(color.R, pow), math.pow(color.G, pow), math.pow(color.B, pow))
end

-- Interpolate between 'ColorA' and 'ColorB' by 'Frac' percentage with an optional 'Gamma' value. 
-- Typical gamma values range from 1.8 to 2.2. The default value is 2.0.
local function LerpColor(colorA: Color3, colorB: Color3, frac: number, gamma: number): Color3
    gamma = gamma or 2.0
    local ca = PowColor3(colorA, gamma)
    local cb = PowColor3(colorB, gamma)
    return PowColor3(ca:Lerp(cb, frac), 1 / gamma)
end
