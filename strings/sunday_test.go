package strings

import "testing"

func TestFindPattern(t *testing.T) {
	cases := []struct {
		text     string
		pattern  string
		expected int
	}{
		{"hello world", "world", 6},
		{"hello world", "hello", 0},
		{"hello world", "lo wo", 3},
		{"hello world", "go", -1},
		{"abcaabcab", "abcab", 4},
	}

	for _, c := range cases {
		got := FindPattern(c.text, c.pattern)
		if got != c.expected {
			t.Errorf("sunday(%q, %q) == %d, want %d", c.text, c.pattern, got, c.expected)
		}
	}
}
