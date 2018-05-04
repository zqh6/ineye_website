module RandomUtil

  def self.included(base)
    base.extend self
  end

  def getRandomStringBy(length: 0)
    source = 'abcdefghijklmnopqrstuvwxyz0123456789'
    generateRandomStringBy source: source, length: length
  end

  def getRandomIntStringBy(length: 0)
    source = '0123456789'
    generateRandomStringBy source: source, length: length
  end

  def generateRandomStringBy(source: nil, length: 0)
    source_length = source.length
    target = ''
    length.times do
      random_number = rand(source_length)
      random_char   = source[random_number]
      target = target+random_char
    end
    target
  end
end
