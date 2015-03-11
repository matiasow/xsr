require 'securerandom'

def random_hash
  {SecureRandom.hex => SecureRandom.hex} 
end

