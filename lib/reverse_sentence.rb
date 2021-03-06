# A method to reverse the words in a sentence, in place.

# METHOD 1: USING .REPLACE, but is that an "in-place" reversal? Really it's a reversal in a new string and replacing the contents of the passed in object with the values of the new string....
# Time complexity: O(nm), where n is number of words in the sentence and m is the number of chars in the sentence
# Space complexity: O(n), where n is the number of words in the sentence
# sources: https://ruby-doc.org/core-2.6.5/String.html#method-i-split;https://ruby-doc.org/core-2.6.5/String.html#method-i-replace
# def reverse_sentence(my_sentence)
#   if my_sentence
#     new_sentence = my_sentence.split(/\ {1}/, my_sentence.length)
#     i = 0
#     j = new_sentence.length - 1
#     while i <= j
#       new_sentence[i], new_sentence[j] = new_sentence[j], new_sentence[i]
#       j -= 1
#       i += 1
#     end
#     my_sentence.replace new_sentence.join(' ')
#   end
#   return my_sentence
# end

# METHOD 2: NOT USING .REPLACE -- it's a plate of spaghetti
# Time complexity: O(nm), where n is number of words in the sentence and m is the number of chars in the sentence
# Space complexity: O(n), where n is the number of words in the sentence
def reverse_sentence(my_sentence)
  if my_sentence
    space_indices = get_num_spaces(my_sentence)
    word_swap(my_sentence, space_indices)
  end
end

def get_num_spaces(sentence)
  original_sentence = sentence.dup
  parsed_sentence = sentence.dup
  space_indices = []
  i = 0
  while parsed_sentence.include?(' ')
    space_index = space_indices[i - 1] ? space_indices[i - 1] + 1 :  0
    space_index += (parsed_sentence =~ /\s/)
    parsed_sentence = original_sentence[space_index + 1..-1]
    space_indices << space_index
    i += 1
  end
  return space_indices
end

def word_swap(sentence, space_indices)
  original_sentence = sentence.dup
  word_first = 0
  unsorted_last = sentence.length - 1

  num_words = space_indices.length + 1

  num_words.times do |i|
    if word_first < original_sentence.length
      space_index = space_indices[i] ? space_indices[i] : original_sentence.length
      word_last = space_index - 1

      sentence[-space_index..unsorted_last] = original_sentence[word_first..word_last]
      #use space_index, but make more negative since counting from string end starts at -1
      if space_index < original_sentence.length
        sentence[-space_index - 1] = " "
      end

      unsorted_last = original_sentence.length - (space_index + 2)
      word_first = space_index + 1
    end
  end
end
