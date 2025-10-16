class PortfolioConfig {
  final bool showContact;
  final bool showExperience;
  final bool showProjects;
  final bool showSkills;
  final bool showAbout;

  const PortfolioConfig({
    this.showContact = true,
    this.showExperience = true,
    this.showProjects = true,
    this.showSkills = true,
    this.showAbout = true,
  });

  // Freelance version - without contact
  factory PortfolioConfig.freelance() {
    return const PortfolioConfig(
      showContact: false,
      showExperience: true,
      showProjects: true,
      showSkills: true,
      showAbout: true,
    );
  }

  // Full version - all sections visible
  factory PortfolioConfig.full() {
    return const PortfolioConfig(
      showContact: true,
      showExperience: true,
      showProjects: true,
      showSkills: true,
      showAbout: true,
    );
  }
}
