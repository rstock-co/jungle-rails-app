describe("User login", () => {
  it("should login a user who uses valid email and password credentials", () => {
    cy.visit("/login");
    cy.get("#email").type("richard@gmail.com");
    cy.get("#password").type("password");
    cy.get(".btn").first().click({ force: true });
    cy.get(".nav-item").get(".nav-link").contains("Logout");
    cy.get(".nav-item").get(".nav-link").contains("Richard Stock");
  });
});
