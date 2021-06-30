def range_iter(st, ed)
    (st...ed).to_a
end

def range_recur(st, ed)
    return [] if st >= ed
    arr = range_recur(st, ed - 1)
    arr << ed - 1
    arr
end

def exp_recur1(a, n)
    return 1 if n == 0
    a * exp_recur1(a, n - 1)
end

def exp_recur2(a, n)
    return 1 if n == 0
    return exp_recur2(a * a, n / 2) if n.even?
    a * exp_recur2(a * a, n / 2)
end

class Array
    def deep_dup
        self.inject([]) do |acc, ele|
            if ele.is_a?(Array)
                acc << ele.deep_dup
            else
                acc << ele
            end
        end
    end

    def subsets
        @sub_list = []
        @list = []
        @sub_list << @list.deep_dup
        helper_sub(0)
        return @sub_list
    end

    def helper_sub(idx)
        return if idx == self.length
        helper_sub(idx + 1)
        @list << self[idx]
        @sub_list << @list.deep_dup
        helper_sub(idx + 1)
        @list.pop
    end
end

def fibonacci(n)
    return [0, 1].take(n) if n < 3
    arr = fibonacci(n - 1)
    arr << arr[-1] + arr[-2]
    arr
end

def bsearch(array, target)
    return nil if array.empty?
    len = array.length
    mid = (len - 1) / 2
    return array[mid] if array[mid] == target
    return bsearch(array[(mid + 1)...len], target) if array[mid] < target
    bsearch(array[0...mid], target)
end

def merge_sort(array)
    return array if array.length < 2
    len = array.length
    mid = (len - 1) / 2
    left, right = merge_sort(array[0..mid]), merge_sort(array[(mid + 1)...len])
    merge(left, right)
end

def merge(arr1, arr2)
    arr, i, j = [], 0, 0
    while i < arr1.length && j < arr2.length
        if arr1[i] < arr2[j]
            arr << arr1[i]
            i += 1
        else
            arr << arr2[j]
            j += 1
        end
    end
    arr += arr1[i...arr1.length]
    arr += arr2[j...arr2.length]
    arr
end

def permutation(arr)
    res = []
    helper_permu(arr, Array.new(arr.length, false), res, [])
    res
end

def helper_permu(arr, seen, res, list)
    if list.length == arr.length
        res << list.deep_dup
        return
    end
    (0...arr.length).each do |i|
        next if seen[i]
        seen[i] = true
        list << arr[i]
        helper_permu(arr, seen, res, list)
        seen[i] = false
        list.pop
    end
end

def greedy_make_change(amount, coin = [25, 10, 5, 1])
    coin.sort!.reverse!
    return [] if amount == 0
    coin.each do |c|
        next if c > amount
        return greedy_make_change(amount - c, coin) << c
    end
    nil
end

def make_better_change(amount, coin = [25, 10, 5, 1])
    return [] if amount == 0
    res = nil
    coin.each do |c|
        next if c > amount
        cur_array = make_better_change(amount - c, coin) << c
        res = cur_array if res.nil? || res.length > cur_array.length
    end
    res
end


