function [CRCValid] = CRCVerifier(genPoly,encodedBits)
% Prepared by : MD MAHEENUL ISLAM
% Monash ID : 24861030
% Date Created : 13/05/2014
%
% Program description : The function verifies the  CRC encoded information 
% bits, using encoded information bits and generating polynomial as inputs.
%
% Variable description
% INPUTS:
% genPoly -> CRC Generating polynomial.
% encodedBits -> CRC Encoded information bits.
% OUTPUTS:
% CRCValid -> Result of the verification of CRC encoded information bits.
% CRCValid = 1 means that the encoded data is valid.
% CRCValid = 0 means that the encoded data is invalid.
%

lengthGen = length(genPoly);
lengthEncode = length(encodedBits);

% Initialisation of variables
maxRounds = lengthEncode - lengthGen + 1;
remainder = encodedBits;
frontZeros=0;
CRCValid=0;

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

if (sum(remainder)==0)
    CRCValid=1;
end