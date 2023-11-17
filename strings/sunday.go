package strings

// FindPattern 查找字符串中的模式串
func FindPattern(text string, pattern string) int {
	// 1. 计算模式串中每个字符最后出现的位置
	var last [256]int
	// 初始化为0, 表示模式串中没有出现该字符, 出现的位置为index+1
	for i := 0; i < len(pattern); i++ {
		last[pattern[i]] = i + 1
	}

	// 2. 匹配过程
	n, m := len(text), len(pattern)
	for i := 0; i <= n-m; {
		j := 0
		for ; j < m; j++ {
			if text[i+j] != pattern[j] {
				if i+m < n {
					if li := last[text[i+m]]; li == 0 {
						i += m + 1
					} else {
						i += m - li + 1
					}
				} else {
					i++
				}
				break
			}
		}
		if j == m {
			return i
		}
	}
	return -1
}
