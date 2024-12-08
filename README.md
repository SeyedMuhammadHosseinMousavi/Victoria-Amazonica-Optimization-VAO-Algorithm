## Victoria Amazonica Optimization (VAO): An Algorithm Inspired by the Giant Water Lily Plant  

### Links to the paper:
- https://arxiv.org/ftp/arxiv/papers/2303/2303.08070.pdf  
- https://paperswithcode.com/paper/victoria-amazonica-optimization-vao-an
### Please cite:
- Mousavi, Seyed Muhammad Hossein. "Victoria Amazonica Optimization (VAO): an algorithm inspired by the giant water Lily Plant." arXiv preprint arXiv:2303.08070 (2023).
- DOI: https://doi.org/10.48550/arXiv.2303.08070
- Developed by Seyed Muhammad Hossein Mousavi - (2022 to 2023)

![VAO Algorithm](https://user-images.githubusercontent.com/11339420/227768464-e2382065-dcb1-4d5a-9acc-4bf5490d803d.JPG)


Victoria Amazonica Optimization (VAO) is a novel bio-inspired algorithm inspired by the unique life cycle of the giant water lily plant. This algorithm models the natural processes of leaf expansion, intra-competition, and hybrid pollination to solve optimization problems effectively. The key inspiration for VAO comes from the biological traits of Victoria Amazonica, including its ability to dominate water surfaces, compete for resources, and undergo genetic diversity through hybridization.

## Biological Inspiration 🌿
The life cycle of the giant water lily plant, Victoria Amazonica, serves as the foundation for this algorithm:
- **Leaf Expansion (⌀)**: Represents the growth and dominance of leaves on the water surface.
- **Intra-Competition (λ)**: Simulates competitive interactions among plants for resources.
- **Hybrid Mutation (μ)**: Models genetic diversity introduced through cross-pollination.
- **Drawback Coefficients (ω, ψ)**: Represent environmental challenges and pests that affect plant growth.

## Algorithm Workflow 🛠️
1. **Initialization**:
   - Initialize a population of plants (positions and costs).
   - Define environmental and competition parameters.
2. **Intra-Competition**:
   - Plants compete based on their costs and adjust positions accordingly.
   - Apply environmental constraints using drawback coefficients (ω, ψ).
3. **Hybrid Mutation**:
   - Introduce randomness through mutation to explore the solution space.
4. **Selection**:
   - Retain the best solutions after each iteration.
5. **Iteration**:
   - Repeat the process for a fixed number of iterations or until convergence.


![image](https://github.com/user-attachments/assets/3021f798-d786-439a-8001-44a33c9132fb)
![image](https://github.com/user-attachments/assets/c839e706-1c27-4ed4-82e9-8499b465035b)


## Applications 🚀
The VAO algorithm has demonstrated superior performance in solving both standard benchmark functions and real-world optimization problems:
1. **Benchmark Functions**:
   - Ackley Function: Multi-modal with many local minima.
   - Zakharov Function: Unimodal with smooth valleys.
   - Rastrigin Function: Multi-modal with periodic patterns.
   - Sphere Function: Unimodal and convex.
   - Booth Function: Multi-modal with plate-like shapes.
   - Beale Function: Unimodal with steep ridges.
2. **Real-World Applications**:
   - Minimum Spanning Tree (MST)
   - Hub Location Allocation (HLA)
   - Quadratic Assignment Problem (QAP)
   - Feature Selection (FS)
   - Economic Dispatching (ED)
   - Parallel Machine Scheduling (PMS)

![image](https://github.com/user-attachments/assets/51367be7-08bc-45ad-98a5-61943bd9e079)
![image](https://github.com/user-attachments/assets/34e71f1d-9dc4-472f-9fa0-712bbbed0875)

## Algorithm Pseudocode 📜
1. Start by initializing the population (plants) with random positions and calculate their costs.
2. For each plant, evaluate its position against others:
   - Adjust position based on intra-competition (λ).
   - Apply environmental constraints (ω, ψ).
3. Introduce hybrid mutation (μ) for diversity.
4. Retain the best-performing plants and update the global best solution.
5. Iterate until convergence or maximum iterations are reached.

## Performance Evaluation 📊
### Benchmark Test Results:
- Ackley: Achieved a best cost of 3.206, outperforming Genetic Algorithm (GA) and Particle Swarm Optimization (PSO).
- Zakharov: Best cost of 92.551, showcasing faster convergence compared to other algorithms.
- Rastrigin: Superior performance with a cost of 139.852.
- Sphere: Simple yet effective with a best cost of 0.002.
- Booth: Achieved near-perfect results with a cost of 0.004.
- Beale: Minimum cost reached at 0.000.

![image](https://github.com/user-attachments/assets/48fa5cc6-538b-41f0-8226-7e25e8f6db57)
![image](https://github.com/user-attachments/assets/1492877e-e38e-407e-bfd2-0f858099b239)

### Real-World Problem Performance:
- MST: Optimized with minimal edge costs.
- HLA: Improved transportation and logistics networks.
- ED: Enhanced energy distribution efficiency.

## Future Work 🧪
- Extending the VAO algorithm to multi-objective optimization.
- Exploring hybridization with other metaheuristic algorithms.
- Improving scalability for large-scale problems.
- Applying VAO in fields like robotics, finance, and healthcare.



## Contact Information 📬
- Author: Seyed Muhammad Hossein Mousavi
- Email: mosavi.a.i.buali@gmail.com
- GitHub: https://github.com/SeyedMuhammadHosseinMousavi




![image](https://github.com/user-attachments/assets/43054d93-6c12-446a-a244-944c48d05b96)
![image](https://github.com/user-attachments/assets/b73492ae-4554-47a7-817a-1120433c59ad)

