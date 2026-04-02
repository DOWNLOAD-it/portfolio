import React, { useState, useEffect } from "react";
import "./App.css";
import { motion, useScroll, useTransform } from "framer-motion";
import AOS from "aos";
import "aos/dist/aos.css";

// Initialize AOS for scroll animations
AOS.init({
  duration: 1000,
  once: true,
  offset: 100,
});

function App() {
  const [darkMode, setDarkMode] = useState(true);
  const { scrollYProgress } = useScroll();
  const scaleX = useTransform(scrollYProgress, [0, 1], [0, 1]);

  useEffect(() => {
    document.body.className = darkMode ? "dark-mode" : "light-mode";
  }, [darkMode]);

  const projects = [
    {
      title: "Infrastructure as Code with Terraform",
      description:
        "Automated cloud resource provisioning using Terraform (HCL). Manages VPC, EC2, security groups, and load balancers across multiple environments.",
      icon: "🏗️",
      tech: ["Terraform", "AWS", "HCL"],
    },
    {
      title: "Configuration Management with Ansible",
      description:
        "Server configuration automation using Ansible playbooks. Handles package installation, user management, and application configuration.",
      icon: "⚙️",
      tech: ["Ansible", "YAML", "Linux"],
    },
    {
      title: "Containerization & Orchestration",
      description:
        "Multi-stage Docker builds for optimized images, plus Kubernetes manifests for deployment, scaling, and service discovery.",
      icon: "🐳",
      tech: ["Docker", "Kubernetes", "Container Registry"],
    },
    {
      title: "CI/CD Pipeline with Jenkins",
      description:
        "Fully automated Jenkins pipeline with stages: code checkout, build, test, Docker image creation, and deployment to Kubernetes.",
      icon: "🔄",
      tech: ["Jenkins", "Groovy", "GitHub Webhooks"],
    },
  ];

  const skills = [
    { name: "Terraform", level: 90, icon: "🏗️" },
    { name: "Ansible", level: 85, icon: "⚙️" },
    { name: "Docker", level: 88, icon: "🐳" },
    { name: "Kubernetes", level: 82, icon: "☸️" },
    { name: "Jenkins", level: 85, icon: "🔄" },
    { name: "AWS", level: 80, icon: "☁️" },
    { name: "Python", level: 75, icon: "🐍" },
    { name: "JavaScript/React", level: 85, icon: "⚛️" },
  ];

  return (
    <div className={`app ${darkMode ? "dark" : "light"}`}>
      <motion.div className="progress-bar" style={{ scaleX }} />

      <nav className="navbar">
        <div className="nav-container">
          <h1 className="logo">DevOps Portfolio</h1>
          <div className="nav-links">
            <a href="#home">Home</a>
            <a href="#projects">Projects</a>
            <a href="#skills">Skills</a>
            <a href="#contact">Contact</a>
            <button
              className="theme-toggle"
              onClick={() => setDarkMode(!darkMode)}
            >
              {darkMode ? "☀️" : "🌙"}
            </button>
          </div>
        </div>
      </nav>

      <section id="home" className="hero">
        <motion.div
          className="hero-content"
          initial={{ opacity: 0, y: 50 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
        >
          <h1 className="hero-title">
            Cloud Infrastructure Automation
            <br />
            <span className="highlight">& CI/CD Pipeline</span>
          </h1>
          <motion.div
            className="typing-container"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.5 }}
          >
            <TypingText
              texts={[
                "Infrastructure as Code",
                "Container Orchestration",
                "CI/CD Automation",
                "Production Ready Deployments",
              ]}
            />
          </motion.div>
          <p className="hero-description">
            A comprehensive DevOps portfolio showcasing modern cloud
            infrastructure automation, containerization, and CI/CD practices
            using industry-standard tools.
          </p>
          <div className="hero-buttons">
            <a href="#projects" className="btn btn-primary">
              View Projects
            </a>
            <a
              href="https://github.com/DOWNLOAD-it/portfolio"
              className="btn btn-secondary"
              target="_blank"
              rel="noopener noreferrer"
            >
              📦 GitHub Repository
            </a>
          </div>
        </motion.div>
      </section>

      <section id="projects" className="projects">
        <div className="container">
          <h2 data-aos="fade-up">Featured Projects</h2>
          <p
            data-aos="fade-up"
            data-aos-delay="100"
            className="section-subtitle"
          >
            End-to-end DevOps implementations
          </p>
          <div className="projects-grid">
            {projects.map((project, index) => (
              <motion.div
                key={index}
                className="project-card"
                data-aos="fade-up"
                data-aos-delay={index * 100}
                whileHover={{ y: -10 }}
                transition={{ type: "spring", stiffness: 300 }}
              >
                <div className="project-icon">{project.icon}</div>
                <h3>{project.title}</h3>
                <p>{project.description}</p>
                <div className="project-tech">
                  {project.tech.map((tech, i) => (
                    <span key={i} className="tech-tag">
                      {tech}
                    </span>
                  ))}
                </div>
                <a href="#" className="project-link">
                  Learn More →
                </a>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      <section id="skills" className="skills">
        <div className="container">
          <h2 data-aos="fade-up">Tech Stack & Skills</h2>
          <p
            data-aos="fade-up"
            data-aos-delay="100"
            className="section-subtitle"
          >
            Tools and technologies I work with
          </p>
          <div className="skills-grid">
            {skills.map((skill, index) => (
              <motion.div
                key={skill.name}
                className="skill-card"
                data-aos="fade-up"
                data-aos-delay={index * 50}
                whileHover={{ scale: 1.05 }}
              >
                <div className="skill-icon">{skill.icon}</div>
                <h3>{skill.name}</h3>
                <div className="skill-bar">
                  <motion.div
                    className="skill-progress"
                    initial={{ width: 0 }}
                    whileInView={{ width: `${skill.level}%` }}
                    transition={{ duration: 1, delay: 0.2 }}
                  />
                </div>
                <span className="skill-percent">{skill.level}%</span>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      <section id="contact" className="contact">
        <div className="container">
          <h2 data-aos="fade-up">Let's Connect</h2>
          <p
            data-aos="fade-up"
            data-aos-delay="100"
            className="section-subtitle"
          >
            Feel free to reach out for collaborations or opportunities
          </p>
          <div
            className="contact-links"
            data-aos="fade-up"
            data-aos-delay="200"
          >
            <a
              href="https://github.com/DOWNLOAD-it"
              target="_blank"
              rel="noopener noreferrer"
              className="contact-item"
            >
              📦 GitHub
            </a>
            <a href="mailto:your.email@example.com" className="contact-item">
              ✉️ Email
            </a>
            <a
              href="https://linkedin.com/in/yourprofile"
              target="_blank"
              rel="noopener noreferrer"
              className="contact-item"
            >
              🔗 LinkedIn
            </a>
          </div>
        </div>
      </section>

      <footer className="footer">
        <p>© 2024 DevOps Portfolio - Built with React, Framer Motion & AOS</p>
      </footer>
    </div>
  );
}

// Typing Text Component
const TypingText = ({ texts }) => {
  const [currentText, setCurrentText] = useState("");
  const [index, setIndex] = useState(0);
  const [subIndex, setSubIndex] = useState(0);
  const [reverse, setReverse] = useState(false);

  useEffect(() => {
    if (subIndex === texts[index].length + 1 && !reverse) {
      setReverse(true);
      setTimeout(() => setReverse(false), 2000);
      return;
    }

    if (reverse && subIndex === 0) {
      setReverse(false);
      setIndex((prev) => (prev + 1) % texts.length);
      return;
    }

    const timeout = setTimeout(
      () => {
        setSubIndex((prev) => prev + (reverse ? -1 : 1));
      },
      reverse ? 50 : 100,
    );

    return () => clearTimeout(timeout);
  }, [subIndex, index, reverse, texts]);

  useEffect(() => {
    setCurrentText(texts[index].substring(0, subIndex));
  }, [subIndex, index, texts]);

  return (
    <div className="typing-text">
      ⚡ {currentText}
      <span className="cursor">|</span>
    </div>
  );
};

export default App;
