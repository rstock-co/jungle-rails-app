describe("Home page", () => {
  it("renders homepage", () => {
    cy.visit("/");
  });
});
describe("Add to Cart", () => {
  it("before clicking add to cart total items is 0", () => {
    cy.get(".nav-item").get(".nav-link").contains("My Cart (0)");
  });
  it("after clicking add to cart total items is 1", () => {
    cy.get(".btn").first().click({ force: true });
    cy.get(".nav-item").get(".nav-link").contains("My Cart (1)");
  });
});
