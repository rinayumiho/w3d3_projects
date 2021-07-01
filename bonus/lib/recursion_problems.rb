#Problem 1: 

def sum_recur(array)
    return 0 if array.empty?
    array.pop + sum_recur(array)
end

#Problem 2: 

def includes?(array, target)
    return false if array.empty?
    return true if target == array.pop
    includes?(array, target)
end

# Problem 3: 

def num_occur(array, target)
    return 0 if array.empty?
    ct = array.pop == target ? 1 : 0
    ct + num_occur(array, target)
end

# Problem 4: 

def add_to_twelve?(array)
    return false if array.length < 2
    ele = array.pop
    return false if ele + array[-1] != 12
    return true if array.length == 1
    add_to_twelve?(array)
end

# Problem 5: 

def sorted?(array)
    return true if array.length < 2
    ele = array.pop
    return false if ele < array[-1]
    sorted?(array)
end

# Problem 6: 

def reverse(string)
    return string if string.length < 2
    string[-1] + reverse(string.chop)
end

