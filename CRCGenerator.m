function [encodedBits] = CRCGenerator(genPoly,infoBits)
% Prepared by : MD MAHEENUL ISLAM
% Monash ID : 24861030
% Date created : 13/05/2014
%
% Program description : The function helps to calculate CRC encoded
% information bits, using raw information bits and a CRC generating 
% polynomial as inputs.
%
% Variable description
% INPUTS:
% genPoly -> CRC generating polynomial.
% infoBits -> Information bits.
% OUTPUTS:
% encodedBits -> CRC encoded information bits.
%
%
% Inputs and encoded bit calculations

lengthGen = length(genPoly);
zeroAppend = zeros(1,lengthGen-1);
encodedBits = [infoBits,zeroAppend];
lengthEncode = length(encodedBits);

% Initialisation of variables
maxRounds = lengthEncode - lengthGen + 1;
remainder = encodedBits;
frontZeros=0;

% Iterates the maximum possible time through the remainder
for i=1:1:maxRounds
    
    % Check for trailing zeros in the remainder
    toggle = 0;
    for j = (frontZeros+1):1:lengthEncode
        if (~toggle && ~remainder(j))
            frontZeros = frontZeros + 1;
        else
            if (~toggle)
                toggle=~toggle;
            end
        end
    end
    
    % Computes new remainder by XOR operation with genpoly after offseting
    % the zeros in the remainder
    if (lengthEncode - frontZeros) >= lengthGen
        remainder(1+frontZeros: frontZeros+lengthGen) = ...
            xor(remainder(1 + frontZeros: frontZeros + lengthGen),genPoly);
    end
end
encodedBits = encodedBits + remainder;