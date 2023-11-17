package version

import (
	"fmt"
	"runtime"
	"strings"
)

var (
	Version    string // 版本
	Message    string // 版本信息
	BuildTime  string // 编译时间
	CommitHash string // commit hash
)

// String 版本详细信息
func String() string {
	kv := [][2]string{
		{"Go", runtime.Version()},
		{"BuildTime", BuildTime},
		{"CommitHash", CommitHash},
		{"Version", Version},
		{"Message", Message},
	}
	sb := strings.Builder{}
	for _, v := range kv {
		sb.WriteString(fmt.Sprintf("%10s: %s\n", v[0], v[1]))
	}
	return sb.String()
}
