<%@ include file="../jsp/headerFrame.jsp" %>

<h4>Liste de mes adresses</h4>

<spring:if test="${not (sessionScope.currentUser.id eq -1)}">
<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#addressform">Ajouter une adresse</button>
</spring:if>

<div class="card mt-1 collapse" id="addressform">
    <div class="card-body">
        <form method="POST" action="/Escalade/address">

            <input type="hidden" name="userfk" value="<spring:out value="${ user.id }" />" />

            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="street">Numéro de voie :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="street" id="street" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="streetname">Nom de voie :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="streetname" id="streetname" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="postalcode">Code postal :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="postalcode" id="postalcode" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="city">Ville :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="city" id="city" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="country">Pays :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="country" id="country" required="required" />
                </div>
            </div>

            <div class="text-right">
                <button class="btn btn-primary" type="submit">Envoyer</button>
            </div>

        </form>
    </div>
</div>

<table class="table table-sm table-striped mt-2">
    <thead>
      <tr>
          <td>#</td>
          <td>N° de voie</td>
          <td>Nom de voie</td>
          <td>Code postal</td>
          <td>Ville</td>
          <spring:if test="${not (sessionScope.currentUser.id eq -1)}">
          <td></td>
          <td></td>
          </spring:if>
      </tr>
    </thead>
    <tbody>
        <spring:forEach var="address" items="${ addresses }">
        <tr>
            <td><spring:out value="${ address.id }" /></td>
            <td><spring:out value="${ address.street }" /></td>
            <td><spring:out value="${ address.streetName }" /></td>
            <td><spring:out value="${ address.postalCode }" /></td>
            <td><spring:out value="${ address.city }" /></td>
            <spring:if test="${not (sessionScope.currentUser.id eq -1)}">
            <td><a href="/Escalade/address/<spring:out value="${ address.id }" />">Voir/Editer</a></td>
            <td><a href="/Escalade/address/delete/<spring:out value="${ address.id }" />">Supprimer</a></td>
            </spring:if>
        </tr>
        </spring:forEach>
    </tbody>
</table>

<%@ include file="../jsp/footerFrame.jsp" %>