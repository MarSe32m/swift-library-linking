#if _WIN32
#define EXPORT __declspec(dllexport)
#else
#define EXPORT __attribute__((visibility(default)))
#endif

EXPORT void printName(const char*);