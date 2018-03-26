
# Simple Program on RSA Envcryption-Decryption in Julia


totientfunc(p, q) = ((p - 1) * (q - 1))


function calculate_data(base, exp, n)
  if exp == 0
    1
  else
    if exp%2!=0
      mod(base * calculate_data(base, exp - 1, n), n)
    else
      mod(abs2(calculate_data(base, fld(exp, oftype(exp, 2)), n)), n)
    end
  end
end

function extended_gcd(a, b)
  if mod(a, b) == 0
    return [0, 1]
  else
    x, y = extended_gcd(b, mod(a, b))
    return [y, x - (y * fld(a, b))]
  end
end

function modulo_inverse(a, n)
  mod(extended_gcd(a, n)[1], n)
end



function check_e(e, p, q)
  return 1 < e && e < totientfunc(p, q) && 1  == gcd(e, totientfunc(p, q))
end


function generate_d(e, p, q)
  if check_e(e, p, q)
    return modulo_inverse(e, totientfunc(p, q))
  else
    @printf("Not a legal public exponent for that modulus")
  end
end

function encryption(m, e, n)
  if m > n
    @printf("The modulus is too small to encryption the message")
  else
    calculate_data(m, e, n)
  end
end


function decryption(c, d, n)
  return calculate_data(c, d, n)
end



#Example Run of RSA encryption-decryption

p = 41                       # Prime-1
q = 47                       # Prime-2
n = p * q                    # public key
e = 7                        # exponent
d = generate_d(e, p ,q)      # Private Key


message = 1024
encrypted__message = encryption(message, e, n)
decrypted_message = decryption(encrypted__message, d, n)


@printf("\n\tOriginal Message   :  %s", message)
@printf("\n\tEncrypted Message  :  %s", encrypted__message)
@printf("\n\tDecrypted Message  :  %s", decrypted_message)


if message != decrypted_message
  @printf("RSA encryption-decryption went wrong!!! ")
end
