#include "../cell_division2/src/cell_division.h"

//int main(int argc, const char** argv) { return bdm::Simulate(argc, argv); }

static void BM_BDM(benchmark::State& state) {
  const char** argv = (const char**) malloc(2);
  argv[0] = "./cell_division";
  argv[1] = NULL;
  int argc = 1;
    for (auto _ : state)
      bdm::Simulate(argc, argv);
}

int main(int argc, const char** argv)
{
//  if (argc == 2 && strcmp(argv[1], "--benchmark") == 0) {
    BENCHMARK(BM_BDM);
    ::benchmark::RunSpecifiedBenchmarks();
    return 0;
//  } return bdm::Simulate(argc, argv);
}