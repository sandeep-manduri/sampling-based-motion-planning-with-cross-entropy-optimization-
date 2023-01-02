# sampling-based-motion-planning-with-cross-entropy-optimization-
getting optimized sampling distribution for RRT* using GMMs

** we can see problem scenario from problem_scenario.pdf

** execute main.m 

**  gmm_fit.m  updates the means and covariances of components in each train run

** biasSampleRandomNode.m to sample the point from the distribution (biasing towards goal to get more paths reaching the goal)

** get_elite_list.m  getting elite training sample data

** Sampled trajectories for 1st & 6th iteration as images

** original paper can be found at https://journals.sagepub.com/doi/epdf/10.1177/0278364912444543
