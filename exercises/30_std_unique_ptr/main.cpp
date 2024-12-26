#include "../exercise.h"
#include <memory>
#include <string>
#include <cstring>
#include <vector>

// READ: `std::unique_ptr` <https://zh.cppreference.com/w/cpp/memory/unique_ptr>

std::vector<std::string> RECORDS;

class Resource {
    std::string _records;

public:
    void record(char record) {
        _records.push_back(record);
    }

    ~Resource() { // NOTE: 当销毁 Resource 的时候，对应 record 数据会被添加到 RECORDS
        RECORDS.push_back(_records);
    }
};

using Unique = std::unique_ptr<Resource>;
Unique reset(Unique ptr) { // NOTE: 创建一个新的 Resource 对象并返回。
    if (ptr) {             // 如果传入的替换被管理对象的新指针有效，则记录 r
        ptr->record('r');
    }
    return std::make_unique<Resource>();
}
Unique drop(Unique ptr) { 
    if (ptr) { // NOTE: 如果传入指针有效，则记录 d，返回 nullptr (生命周期结束？)
        ptr->record('d');
    }
    return nullptr;
}
Unique forward(Unique ptr) {
    if (ptr) { // NOTE: 如果传入指针有效，则记录 f
        ptr->record('f');
    }
    return ptr;
}

int main(int argc, char **argv) {
    std::vector<std::string> problems[3];

    drop(forward(reset(nullptr)));
    problems[0] = std::move(RECORDS);

    forward(drop(reset(forward(forward(reset(nullptr))))));
    problems[1] = std::move(RECORDS);

    drop(drop(reset(drop(reset(reset(nullptr))))));
    problems[2] = std::move(RECORDS);

    // ---- 不要修改以上代码 ----

    std::vector<const char *> answers[]{
        {"fd"},
        {"d", "ffr"}, // 外围的先析构
        {"d", "d", "r"},
    };

    // ---- 不要修改以下代码 ----

    for (auto i = 0; i < 3; ++i) {
        ASSERT(problems[i].size() == answers[i].size(), "wrong size");
        for (auto j = 0; j < problems[i].size(); ++j) {
            ASSERT(std::strcmp(problems[i][j].c_str(), answers[i][j]) == 0, "wrong location");
        }
    }

    return 0;
}
