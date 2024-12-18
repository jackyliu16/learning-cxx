#include "../exercise.h"

// READ: `static` 关键字 <https://zh.cppreference.com/w/cpp/language/storagenix run github:jordanisaacs/neovim-flake --no-write-lock-file_duration>
// THINK: 这个函数的两个 `static` 各自的作用是什么？
static int func(int param) {
    static int static_ = param; // 在全局状态下只会被初始化一次
    std::cout << "static_ = " << static_ << std::endl;
    return static_++;
}

int main(int argc, char **argv) {
    ASSERT(func(5) == 5, "static variable value incorrect");
    ASSERT(func(4) == 6, "static variable value incorrect");
    ASSERT(func(3) == 7, "static variable value incorrect");
    ASSERT(func(2) == 8, "static variable value incorrect");
    ASSERT(func(1) == 9, "static variable value incorrect");
    return 0;
}
